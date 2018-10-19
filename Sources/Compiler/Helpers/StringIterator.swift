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

  @discardableResult
  func next() -> String? {
    guard !isDone else { return nil }
    defer { cursor += 1 }
    return current
  }

  func consumeLexeme(maxSize: Int? = nil, where predicate: (String) -> Bool) -> String? {
    var lexeme: String? = nil

    while predicate(current) {
      lexeme = (lexeme ?? "") + current
      next()
      guard !isDone else { break }
      if lexeme?.count == maxSize { break }
    }

    return lexeme
  }
}
