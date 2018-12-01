struct BuildCommand: Command {
  static let options: [Flag] = [.target]

  let options: Options
  let fileSystem: FileSystem

  func run() throws {
    let compiler = try compilerForTarget()
    let sourceFiles = try readSourceFiles("/src")
    let compiledFiles = try compiler.compile(sourceFiles)
    try write(compiledFiles, at: "/.build")
  }

  private func compilerForTarget() throws -> Compiler {
    let target = try requireOption(.target)
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
