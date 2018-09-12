struct Lexer {
  private let matcher = CharacterMatcher.self

  func tokenize(_ source: String) -> [Token] {
    var tokens: [Token] = []
    var remainder = source

    while let match = matcher.find(remainder) {
      tokens.append(match.token)
      remainder = match.remainder ?? ""
    }

    return tokens
  }
}
