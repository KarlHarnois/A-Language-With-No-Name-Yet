protocol CodeGenerator {
  func genCode(from ast: Node) throws -> File
}
