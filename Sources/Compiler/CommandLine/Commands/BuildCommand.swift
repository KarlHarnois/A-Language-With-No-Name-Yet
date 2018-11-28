struct BuildCommand: Command {
  static let options: [Flag] = [.target]

  let options: Options

  func run() throws {
    guard let target = option(.target) else {
      throw Error.missingRequiredOption(.target)
    }
    guard target == "jvm" else {
      throw Error.invalidOption(.target, target)
    }
  }
}
