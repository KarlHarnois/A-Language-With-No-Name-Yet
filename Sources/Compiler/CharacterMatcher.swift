import Foundation

enum CharacterMatcher {
  case space, number, newline, `operator`,
       openParen, closeParen, openSquare, closeSquare, openCurly, closeCurly,
       dot

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
    case .openParen:
      return "(" == char
    case .closeParen:
      return ")" == char
    case .openSquare:
      return "[" == char
    case .closeSquare:
      return "]" == char
    case .openCurly:
      return "{" == char
    case .closeCurly:
      return "}" == char
    case .dot:
      return "." == char
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
    case .openParen:
      return .openParen
    case .closeParen:
      return .closeParen
    case .openSquare:
      return .openSquare
    case .closeSquare:
      return .closeSquare
    case .openCurly:
      return .openCurly
    case .closeCurly:
      return .closeCurly
    case .dot:
      return .dot
    }
  }

  private static var all: [CharacterMatcher] {
    return [.space, .number, .newline, .operator, .openParen, .closeParen, .openSquare, .closeSquare, .openCurly, .closeCurly, .dot]
  }
}
