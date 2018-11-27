import Foundation

public struct CommandLineInterface {
  private let args: [String]

  public init(args: [String] = CommandLine.arguments) {
    var args = args
    args.removeFirst()
    self.args = args
  }

  public func run() throws {
    guard let command = command, command != "help" else {
      throw Error.custom("help command not implemented yet")
    }
    guard command == "build" else {
      throw Error.invalidCommand(command)
    }
  }

  private var command: String? {
    return args.first?.lowercased()
  }
}
