struct BuildCommand: Command {
  let options: [Flag: String]

  func run() throws {
    guard let target = options[.target] else {
      throw Error.missingTarget
    }
    guard target == "jvm" else {
      throw Error.invalidTarget(target)
    }
  }
}
