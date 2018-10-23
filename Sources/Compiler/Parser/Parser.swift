struct Parser {
  func parse(_ tokens: [Token]) -> Node {
    let program = ProgramDeclaration()
    let producer = AstProducer(tokens.iterator)

    while let node = producer.walk() {
      program.add(node)
    }

    return program
  }
}
