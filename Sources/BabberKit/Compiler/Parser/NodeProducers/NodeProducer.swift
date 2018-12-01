protocol NodeProducerDelegate: class {
  func walk() -> Node?
}

class NodeProducer {
  typealias Options = [String: Any]

  private let iterator: Iterator<[Token]>
  private weak var delegate: NodeProducerDelegate?

  init(iterator: Iterator<[Token]>, delegate: NodeProducerDelegate) {
    self.iterator = iterator
    self.delegate = delegate
  }

  func produce(_ opt: Options = [:]) -> Node? {
    return nil
  }

  internal var current: Token? {
    return iterator.current
  }

  internal func walk() -> Node? {
    return delegate?.walk()
  }

  internal var hasNext: Bool {
    return !iterator.isDone
  }

  internal func next() -> Token? {
    return iterator.next()
  }

  internal func advance(to token: Token) {
    while let next = iterator.next() {
      if next == token { break }
    }
  }
}
