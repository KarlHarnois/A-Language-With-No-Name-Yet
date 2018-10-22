protocol Iterable {
  associatedtype Value

  var count: Int { get }
  func element(at index: Int) -> Value
}

extension Iterable {
  var iterator: Iterator<Self> {
    return Iterator(iterable: self)
  }
}

extension Array: Iterable {
  func element(at index: Int) -> Element {
    return self[index]
  }
}

extension String: Iterable {
  func element(at index: Int) -> String {
    return self[index]
  }
}

final class Iterator<A: Iterable> {
  private let iterable: A
  private(set) var cursor = 0

  init(iterable: A) {
    self.iterable = iterable
  }

  var isDone: Bool {
    return cursor >= iterable.count
  }

  var current: A.Value {
    return iterable.element(at: cursor)
  }

  @discardableResult
  func next() -> A.Value? {
    guard !isDone else { return nil }
    defer { cursor += 1 }
    return current
  }
}
