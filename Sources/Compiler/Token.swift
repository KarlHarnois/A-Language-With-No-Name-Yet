enum Token {
  case space(Int)
  case number(String)
  case newline
  case `operator`(String)
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
    default:
      return false
    }
  }
}
