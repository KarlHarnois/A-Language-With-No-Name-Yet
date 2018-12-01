struct BuildCommand: Command {
  static let options: [Flag] = [.target]

  let options: Options
  let fileSystem: FileSystem

  func run() throws {
    let target = try requireOption(.target)
    let compiler = try createCompiler(target: target)
    let sourceFiles = try readSourceFiles("/src")
    let compiledFiles = try compiler.compile(sourceFiles)
    try write(compiledFiles, at: "/.build")
  }

  private func createCompiler(target: String) throws -> Compiler {
    guard target == "jvm" else {
      throw Error.invalidOption(.target, target)
    }
    let generator = JavaBytecodeGenerator()
    return Compiler(codeGenerator: generator)
  }

  private func readSourceFiles(_ path: String) throws -> [File] {
    let dir = Directory(relativePath: path)
    return try fileSystem.readAll(ext: "babber", from: dir)
  }

  private func write(_ files: [File], at path: String) throws {
    let dir = Directory(relativePath: path)
    try fileSystem.write(files, in: dir)
  }
}
