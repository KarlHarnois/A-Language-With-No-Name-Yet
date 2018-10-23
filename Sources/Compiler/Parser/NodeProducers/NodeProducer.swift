protocol NodeProducerDelegate: class {
  func walk() -> Node?
  func walk(until stopChecker: (Token) -> Bool) -> Node?
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

  internal func walk(until stopChecker: (Token) -> Bool) -> Node? {
    return delegate?.walk(until: stopChecker)
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
