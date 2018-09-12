struct Lexer {
  func tokenize(_ source: String) -> [Token] {
    return tokenize(remainder: source, acc: [])
  }

  private func tokenize(remainder: String, acc: [Token]) -> [Token] {
    guard let match = CharacterConsumer.consume(remainder) else {
      return acc
    }
    let tokens = acc + [match.token]
    return tokenize(remainder: match.remainder ?? "", acc: tokens)
  }
}
