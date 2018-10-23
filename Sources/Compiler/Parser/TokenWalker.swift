final class TokenWalker: NodeProducerDelegate {
  private let iter: Iterator<[Token]>

  init(_ iter: Iterator<[Token]>) {
    self.iter = iter
  }

  func walk() -> Node? {
    guard let token = iter.next() else {
      return nil
    }
    switch token {
    case .number(let value):
      return NumberLiteral(value)
    case .quote:
      return StringProducer(iterator: iter, delegate: self).produce()
    case .label("msg"):
      return MessageProducer(iterator: iter, delegate: self).produce()
    case .label("class"):
      return ClassProducer(iterator: iter, delegate: self).produce()
    default:
      return nil
    }
  }
}
