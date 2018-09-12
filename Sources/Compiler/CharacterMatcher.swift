import Foundation

enum CharacterMatcher {
  case space, number, newline, `operator`,
       openParen, closeParen, openSquare, closeSquare, openCurly, closeCurly,
       dot, comma

  struct Match {
    let tokens: [Token]
    let remainder: String?
  }

  static func find(_ source: String) -> Match? {
    return all.reduce(nil) { match, matcher in
      match ?? matcher.find(source)
    }
  }

  func find(_ source: String) -> Match? {
    let iterator = CharacterIterator(source: source, predicate: predicate)
    guard let tokens = iterator.prefix.map(tokens) else {
      return nil
    }
    return Match(tokens: tokens, remainder: iterator.suffix)
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
    case .comma:
      return "," == char
    }
  }

  private func tokens(lexeme: String) -> [Token] {
    switch self {
    case .space:
      return [.space(lexeme.count)]
    case .number:
      return [.number(lexeme)]
    case .newline:
      return [.newline]
    case .operator:
      return [.operator(lexeme)]
    case .openParen:
      return (1...lexeme.count).map { _ in .openParen }
    case .closeParen:
      return (1...lexeme.count).map { _ in .closeParen }
    case .openSquare:
      return (1...lexeme.count).map { _ in .openSquare }
    case .closeSquare:
      return (1...lexeme.count).map { _ in .closeSquare }
    case .openCurly:
      return (1...lexeme.count).map { _ in .openCurly }
    case .closeCurly:
      return (1...lexeme.count).map { _ in .closeCurly }
    case .dot:
      return (1...lexeme.count).map { _ in .dot }
    case .comma:
      return (1...lexeme.count).map { _ in .comma }
    }
  }

  private static var all: [CharacterMatcher] {
    return [.space, .number, .newline, .operator, .openParen, .closeParen, .openSquare, .closeSquare, .openCurly, .closeCurly, .dot, .comma]
  }
}
