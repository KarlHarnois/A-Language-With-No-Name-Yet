protocol Command {
  static var options: [Flag] { get }
  func run() throws
}
