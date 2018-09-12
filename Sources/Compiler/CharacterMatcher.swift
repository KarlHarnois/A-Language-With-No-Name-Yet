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
      return lexeme.count.times { .newline }
    case .operator:
      return [.operator(lexeme)]
    case .openParen:
      return lexeme.count.times { .openParen }
    case .closeParen:
      return lexeme.count.times { .closeParen }
    case .openSquare:
      return lexeme.count.times { .openSquare }
    case .closeSquare:
      return lexeme.count.times { .closeSquare }
    case .openCurly:
      return lexeme.count.times { .openCurly }
    case .closeCurly:
      return lexeme.count.times { .closeCurly }
    case .dot:
      return lexeme.count.times { .dot }
    case .comma:
      return lexeme.count.times { .comma }
    }
  }

  private static var all: [CharacterMatcher] {
    return [.space, .number, .newline, .operator, .openParen, .closeParen, .openSquare, .closeSquare, .openCurly, .closeCurly, .dot, .comma]
  }
}
