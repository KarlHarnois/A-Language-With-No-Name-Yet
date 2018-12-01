struct JavaBytecodeGenerator: CodeGenerator {
  func genCode(from ast: Node) throws -> File {
    return File(name: "", ext: "class", content: "")
  }
}
