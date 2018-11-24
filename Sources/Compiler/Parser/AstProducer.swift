final class AstProducer: NodeProducerDelegate {
  private let iter: Iterator<[Token]>

  private lazy var string     = StringProducer(iterator: iter, delegate: self)
  private lazy var message    = MessageProducer(iterator: iter, delegate: self)
  private lazy var `class`    = ClassProducer(iterator: iter, delegate: self)
  private lazy var expression = ExpressionProducer(iterator: iter, delegate: self)
  private lazy var `print`    = PrintStatementProducer(iterator: iter, delegate: self)
  private lazy var assignment = AssignmentProducer(iterator: iter, delegate: self)

  init(_ tokens: [Token]) {
    self.iter = Iterator(iterable: tokens)
    iter.trimWhitespaces()
  }

  func walk() -> Node? {
    guard let token = iter.next() else {
      return nil
    }
    switch token {
    case .number(let value): return NumberLiteral(value)
    case .quote:             return string.produce()
    case .label("msg"):      return message.produce()
    case .label("class"):    return `class`.produce()
    case .label("print"):    return `print`.produce()
    case .label(let label):  return parse(label: label)
    default:                 return nil
    }
  }

  private func parse(label: String) -> Node? {
    var i = 1
    while let token = iter.element(steps: i) {
      switch token {
      case .label, .newline: return expression.produce(["label": label])
      case .operator("="):   return assignment.produce(["variableName": label])
      default:
        i += 1
        continue
      }
    }
    return expression.produce(["label": label])
  }
}
