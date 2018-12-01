struct Compiler {
  let codeGenerator: CodeGenerator

  private let lexer = Lexer()
  private let parser = Parser()

  func compile(_ files: [File]) throws -> [File] {
    return try files.map(compile)
  }

  private func compile(_ file: File) throws -> File {
    let tokens = lexer.tokenize(file.content)
    let ast = parser.parse(fileName: file.name, tokens: tokens)
    return try codeGenerator.genCode(from: ast)
  }
}
