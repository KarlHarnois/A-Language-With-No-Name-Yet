struct Lexer {
  func tokenize(_ source: String) -> [Token] {
    var tokens: [Token] = []
    let iter = source.iterator

    while !iter.isDone {
      guard let token = consumeToken(iter) else {
        fatalError("Unidentified character: \(iter.current).")
      }
      tokens.append(token)
    }

    return tokens
  }

  private func consumeToken(_ iter: StringIterator) -> Token? {
    return tokenConsumers.reduce(nil) { token, consumer in
      token ?? consumer(iter)
    }
  }

  private var tokenConsumers: [(StringIterator) -> Token?] {
    return [
      consumeSpace, consumeNewline, consumeOpenParen, consumeCloseParen, consumeOpenSquare,
      consumeCloseSquare, consumeOpenCurly, consumeCloseCurly, consumeNumber, consumeOperator,
      consumeDot, consumeComma, consumeColon, consumeLabel, consumeQuote
    ]
  }

  private func consumeSpace(_ iter: StringIterator) -> Token? {
    return iter.consumeLexeme(where: { $0 == " " })
      .map { .space($0.count) }
  }

  private func consumeNewline(_ iter: StringIterator) -> Token? {
    return iter.consumeLexeme(maxSize: 1, where: { $0 == "\n" })
      .map { _ in .newline }
  }

  private func consumeOpenParen(_ iter: StringIterator) -> Token? {
    return iter.consumeLexeme(maxSize: 1, where: { $0 == "(" })
      .map { _ in .openParen }
  }

  private func consumeCloseParen(_ iter: StringIterator) -> Token? {
    return iter.consumeLexeme(maxSize: 1, where: { $0 == ")" })
      .map { _ in .closeParen }
  }

  private func consumeOpenSquare(_ iter: StringIterator) -> Token? {
    return iter.consumeLexeme(maxSize: 1, where: { $0 == "[" })
      .map { _ in .openSquare }
  }

  private func consumeCloseSquare(_ iter: StringIterator) -> Token? {
    return iter.consumeLexeme(maxSize: 1, where: { $0 == "]" })
      .map { _ in .closeSquare }
  }

  private func consumeOpenCurly(_ iter: StringIterator) -> Token? {
    return iter.consumeLexeme(maxSize: 1, where: { $0 == "{" })
      .map { _ in .openCurly }
  }

  private func consumeCloseCurly(_ iter: StringIterator) -> Token? {
    return iter.consumeLexeme(maxSize: 1, where: { $0 == "}" })
      .map { _ in .closeCurly }
  }

  private func consumeNumber(_ iter: StringIterator) -> Token? {
    return iter.consumeLexeme(where: { $0.match("[0-9]") })
      .map { .number($0) }
  }

  private func consumeOperator(_ iter: StringIterator) -> Token? {
    return iter.consumeLexeme(where: { $0.match("^(\\+|-|\\*|\\/|\\||=|\\!|&+|>|<)") })
      .map { .operator($0) }
  }

  private func consumeDot(_ iter: StringIterator) -> Token? {
    return iter.consumeLexeme(maxSize: 1, where: { $0 == "." })
      .map { _ in .dot }
  }

  private func consumeComma(_ iter: StringIterator) -> Token? {
    return iter.consumeLexeme(maxSize: 1, where: { $0 == "," })
      .map { _ in .comma }
  }

  private func consumeColon(_ iter: StringIterator) -> Token? {
    return iter.consumeLexeme(maxSize: 1, where: { $0 == ":" })
      .map { _ in .colon }
  }

  private func consumeLabel(_ iter: StringIterator) -> Token? {
    return iter.consumeLexeme(where: {  $0.match("[a-zA-Z]|_") })
      .map { .label($0) }
  }

  private func consumeQuote(_ iter: StringIterator) -> Token? {
    return iter.consumeLexeme(maxSize: 1, where: { $0 == "\"" })
      .map { _ in .quote}
  }
}
