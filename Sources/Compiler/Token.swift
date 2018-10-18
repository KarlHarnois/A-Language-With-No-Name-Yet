enum Token {
  case space(Int)
  case number(String)
  case newline
  case `operator`(String)
  case openParen, closeParen
  case openSquare, closeSquare
  case openCurly, closeCurly
  case dot
  case comma
  case colon
  case label(String)
  case quote
}

extension Token: Equatable {
  public static func == (x: Token, y: Token) -> Bool {
    switch (x, y) {
    case (let .space(a), let .space(b)):
      return a == b
    case (let .number(a), let .number(b)):
      return a == b
    case (.newline, .newline):
      return true
    case (let .operator(a), let .operator(b)):
      return a == b
    case (.openParen, .openParen):
      return true
    case (.closeParen, .closeParen):
      return true
    case (.openSquare, .openSquare):
      return true
    case (.closeSquare, .closeSquare):
      return true
    case (.openCurly, .openCurly):
      return true
    case (.closeCurly, .closeCurly):
      return true
    case (.dot, .dot):
      return true
    case (.comma, .comma):
      return true
    case (.colon, .colon):
      return true
    case (let .label(a), let .label(b)):
      return a == b
    case (.quote, .quote):
      return true
    default:
      return false
    }
  }
}
