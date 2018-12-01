struct BuildCommand: Command {
  static let options: [Flag] = [.target]

  let options: Options
  let fileSystem: FileSystem

  func run() throws {
    let target = try requireOption(.target)

    guard target == "jvm" else {
      throw Error.invalidOption(.target, target)
    }
  }
}
