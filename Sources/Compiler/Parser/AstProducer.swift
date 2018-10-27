final class AstProducer: NodeProducerDelegate {
  private let iter: Iterator<[Token]>

  private lazy var string = StringProducer(iterator: iter, delegate: self)
  private lazy var message = MessageProducer(iterator: iter, delegate: self)
  private lazy var `class` = ClassProducer(iterator: iter, delegate: self)
  private lazy var expression = ExpressionProducer(iterator: iter, delegate: self)

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
    case .label(let label):  return expression.produce(["label": label])
    default:                 return nil
    }
  }
}
