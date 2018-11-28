struct BuildCommand: Command {
  static let options: [Flag] = [.target]

  let options: [Flag: String]

  func run() throws {
    guard let target = options[.target] else {
      throw Error.missingRequiredOption(.target)
    }
    guard target == "jvm" else {
      throw Error.invalidOption(.target, target)
    }
  }
}
