struct Parser {
  func parse(fileName: String, tokens: [Token]) -> Node {
    let file = FileDeclaration(name: fileName)
    let producer = AstProducer(tokens)

    while let node = producer.walk() {
      file.add(node)
    }

    return file
  }
}
