final class StringIterator {
  private let str: String
  private var cursor = 0

  init(_ str: String) {
    self.str = str
  }

  var current: String {
    return str[cursor]
  }

  var hasNext: Bool {
    return cursor < str.count - 1
  }

  var isDone: Bool {
    return cursor >= str.count
  }

  func next() {
    cursor += 1
  }
}
