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
    let command = try self.command(named: name)
    try command.run()
  }

  private var commandName: String? {
    return args.first?.lowercased()
  }

  private func command(named name: String) throws -> Command {
    switch name {
    case "build":
      let options = try parseOptions(allowed: BuildCommand.options)
      return BuildCommand(options: options)
    default:
      throw Error.invalidCommand(name)
    }
  }

  private func parseOptions(allowed: [Flag]) throws -> Options {
    let optionArguments = Array(args.dropFirst())
    return try OptionParser(args: optionArguments, allowed: allowed).parse()
  }
}
