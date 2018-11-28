protocol Command {
  static var options: [Flag] { get }
  var options: Options { get }
  init(options: Options, fileSystem: FileSystem)
  func run() throws
}

extension Command {
  func requireOption(_ flag: Flag) throws -> String {
    guard let value = option(flag) else {
      throw Error.missingRequiredOption(flag)
    }
    return value
  }

  func option(_ flag: Flag) -> String? {
    guard case .some(.some(let value)) = options[flag] else {
      return nil
    }
    return value
  }
}
