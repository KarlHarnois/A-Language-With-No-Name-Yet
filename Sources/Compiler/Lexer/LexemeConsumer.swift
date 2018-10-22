struct LexemeConsumer {
  let iterator: Iterator<String>

  func consumeLexeme(maxSize: Int? = nil, where predicate: (String) -> Bool) -> String? {
    var lexeme: String?

    while !iterator.isDone {
      guard predicate(iterator.current) else { break }
      guard let char = iterator.next() else { break }
      lexeme = (lexeme ?? "") + char
      if lexeme?.count == maxSize { break }
    }

    return lexeme
  }
}
