struct Lexer {
  func tokenize(_ source: String) -> [Token] {
    var tokens: [Token] = []
    var remainder = source

    while let match = CharacterConsumer.consume(remainder) {
      tokens.append(match.token)
      remainder = match.remainder ?? ""
    }

    return tokens
  }
}
