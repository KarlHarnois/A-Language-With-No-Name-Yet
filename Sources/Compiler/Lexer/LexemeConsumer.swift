struct LexemeConsumer {
  let iterator: Iterator<String>

  func consumeLexeme(maxSize: Int? = nil, where predicate: (String) -> Bool) -> String? {
    var lexeme: String? = nil

    while predicate(iterator.current) {
      lexeme = (lexeme ?? "") + iterator.current
      iterator.next()
      guard !iterator.isDone else { break }
      if lexeme?.count == maxSize { break }
    }

    return lexeme
  }
}
