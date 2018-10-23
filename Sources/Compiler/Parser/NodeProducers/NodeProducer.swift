protocol NodeProducerDelegate: class {
  func walk() -> Node?
}

class NodeProducer {
  private let iterator: Iterator<[Token]>
  private weak var delegate: NodeProducerDelegate?

  init(iterator: Iterator<[Token]>, delegate: NodeProducerDelegate) {
    self.iterator = iterator
    self.delegate = delegate
  }

  func produce() -> Node? {
    return nil
  }

  internal var current: Token? {
    return iterator.current
  }

  internal var isDoneIterating: Bool {
    return iterator.isDone
  }

  internal func walk() -> Node? {
    return delegate?.walk()
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
