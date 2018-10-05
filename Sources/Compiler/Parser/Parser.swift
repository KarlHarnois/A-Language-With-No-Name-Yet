struct Parser {
  func parse(_ tokens: [Token]) -> Node {
    let program = ProgramDeclaration()
    tokens.map(node).forEach(program.add)
    return program
  }

  private func node(_ token: Token) -> Node {
    switch token {
    case .number(let value):
      return NumberLiteral(value)
    default:
      fatalError()
    }
  }
}
