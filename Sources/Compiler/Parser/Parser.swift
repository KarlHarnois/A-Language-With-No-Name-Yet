struct Parser {
  func parse(_ tokens: [Token]) -> Node {
    let program = ProgramDeclaration()
    let walker = TokenWalker(tokens.iterator)

    while let node = walker.walk() {
      program.add(node)
    }

    return program
  }
}
