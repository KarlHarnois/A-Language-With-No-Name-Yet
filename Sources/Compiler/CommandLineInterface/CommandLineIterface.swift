import Foundation

public struct CommandLineInterface {
  private let args: [String]

  public init(args: [String] = CommandLine.arguments) {
    self.args = Array(args.dropFirst())
  }

  public func run() throws {
    guard let name = commandName, name != "help" else {
      throw Error.custom("help command not implemented yet")
    }
    guard let command = try self.command(named: name) else {
      throw Error.invalidCommand(name)
    }
    try command.run()
  }

  private var commandName: String? {
    return args.first?.lowercased()
  }

  private func command(named name: String) throws -> Command? {
    let optionArguments = Array(args.dropFirst())
    let options = try OptionParser(args: optionArguments).parse()

    switch name {
    case "build": return BuildCommand(options: options)
    default:      return nil
    }
  }
}
