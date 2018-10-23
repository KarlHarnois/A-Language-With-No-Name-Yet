final class TokenWalker: NodeProducerDelegate {
  private let iter: Iterator<[Token]>

  private lazy var string = StringProducer(iterator: iter, delegate: self)
  private lazy var message = MessageProducer(iterator: iter, delegate: self)
  private lazy var `class` = ClassProducer(iterator: iter, delegate: self)

  init(_ iter: Iterator<[Token]>) {
    self.iter = iter
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
    default:                 return nil
    }
  }
}
