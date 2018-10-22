struct Lexer {
  func tokenize(_ source: String) -> [Token] {
    var tokens: [Token] = []
    let iterator = source.iterator
    let consumer = LexemeConsumer(iterator: iterator)

    while !iterator.isDone {
      guard let token = consumeToken(consumer) else {
        fatalError("Unidentified character: \(iterator.current).")
      }
      tokens.append(token)
    }

    return tokens
  }

  private func consumeToken(_ lexemeConsumer: LexemeConsumer) -> Token? {
    return tokenConsumers.reduce(nil) { token, tokenConsumer in
      token ?? tokenConsumer(lexemeConsumer)
    }
  }

  private var tokenConsumers: [(LexemeConsumer) -> Token?] {
    return [
      consumeSpace, consumeNewline, consumeOpenParen, consumeCloseParen, consumeOpenSquare,
      consumeCloseSquare, consumeOpenCurly, consumeCloseCurly, consumeNumber, consumeOperator,
      consumeDot, consumeComma, consumeColon, consumeLabel, consumeQuote
    ]
  }

  private func consumeSpace(_ consumer: LexemeConsumer) -> Token? {
    return consumer.consumeLexeme(where: { $0 == " " })
      .map { .space($0.count) }
  }

  private func consumeNewline(_ consumer: LexemeConsumer) -> Token? {
    return consumer.consumeLexeme(maxSize: 1, where: { $0 == "\n" })
      .map { _ in .newline }
  }

  private func consumeOpenParen(_ consumer: LexemeConsumer) -> Token? {
    return consumer.consumeLexeme(maxSize: 1, where: { $0 == "(" })
      .map { _ in .openParen }
  }

  private func consumeCloseParen(_ consumer: LexemeConsumer) -> Token? {
    return consumer.consumeLexeme(maxSize: 1, where: { $0 == ")" })
      .map { _ in .closeParen }
  }

  private func consumeOpenSquare(_ consumer: LexemeConsumer) -> Token? {
    return consumer.consumeLexeme(maxSize: 1, where: { $0 == "[" })
      .map { _ in .openSquare }
  }

  private func consumeCloseSquare(_ consumer: LexemeConsumer) -> Token? {
    return consumer.consumeLexeme(maxSize: 1, where: { $0 == "]" })
      .map { _ in .closeSquare }
  }

  private func consumeOpenCurly(_ consumer: LexemeConsumer) -> Token? {
    return consumer.consumeLexeme(maxSize: 1, where: { $0 == "{" })
      .map { _ in .openCurly }
  }

  private func consumeCloseCurly(_ consumer: LexemeConsumer) -> Token? {
    return consumer.consumeLexeme(maxSize: 1, where: { $0 == "}" })
      .map { _ in .closeCurly }
  }

  private func consumeNumber(_ consumer: LexemeConsumer) -> Token? {
    return consumer.consumeLexeme(where: { $0.match("[0-9]") })
      .map { .number($0) }
  }

  private func consumeOperator(_ consumer: LexemeConsumer) -> Token? {
    return consumer.consumeLexeme(where: { $0.match("^(\\+|-|\\*|\\/|\\||=|\\!|&+|>|<)") })
      .map { .operator($0) }
  }

  private func consumeDot(_ consumer: LexemeConsumer) -> Token? {
    return consumer.consumeLexeme(maxSize: 1, where: { $0 == "." })
      .map { _ in .dot }
  }

  private func consumeComma(_ consumer: LexemeConsumer) -> Token? {
    return consumer.consumeLexeme(maxSize: 1, where: { $0 == "," })
      .map { _ in .comma }
  }

  private func consumeColon(_ consumer: LexemeConsumer) -> Token? {
    return consumer.consumeLexeme(maxSize: 1, where: { $0 == ":" })
      .map { _ in .colon }
  }

  private func consumeLabel(_ consumer: LexemeConsumer) -> Token? {
    return consumer.consumeLexeme(where: {  $0.match("[a-zA-Z]|_") })
      .map { .label($0) }
  }

  private func consumeQuote(_ consumer: LexemeConsumer) -> Token? {
    return consumer.consumeLexeme(maxSize: 1, where: { $0 == "\"" })
      .map { _ in .quote}
  }
}

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
