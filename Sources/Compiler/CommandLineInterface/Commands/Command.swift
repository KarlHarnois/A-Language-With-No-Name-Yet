protocol Command {
  static var options: [Flag] { get }
  var options: Options { get }
  func run() throws
}

extension Command {
  func option(_ flag: Flag) -> String? {
    guard case .some(.some(let value)) = options[flag] else {
      return nil
    }
    return value
  }
}
