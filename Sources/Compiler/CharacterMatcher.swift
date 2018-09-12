enum CharacterMatcher {
  case space, number, newline, `operator`

  struct Match {
    let token: Token
    let remainder: String?
  }

  static func find(_ source: String) -> Match? {
    return all.reduce(nil) { match, matcher in
      match ?? matcher.find(source)
    }
  }

  func find(_ source: String) -> Match? {
    let iterator = CharacterIterator(source: source, predicate: predicate)
    guard let token = iterator.prefix.map(token) else {
      return nil
    }
    return Match(token: token, remainder: iterator.suffix)
  }

  private func predicate(char: String) -> Bool {
    switch self {
    case .space:
      return char == " "
    case .number:
      return Int(char) != nil
    case .newline:
      return char == "\n"
    case .operator:
      return ["+", "-", "=", "/", "*", "&", "|"].contains(char)
    }
  }

  private func token(lexeme: String) -> Token {
    switch self {
    case .space:
      return .space(lexeme.count)
    case .number:
      return .number(lexeme)
    case .newline:
      return .newline
    case .operator:
      return .operator(lexeme)
    }
  }

  private static var all: [CharacterMatcher] {
    return [.space, .number, .newline, .operator]
  }
}
