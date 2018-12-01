import Foundation

public struct CommandLineInterface {
  private let args: [String]
  private let fileSystem: FileSystem

  public init(args: [String] = CommandLine.arguments, fileSystem: FileSystem = DefaultFileSystem()) {
    self.args = Array(args.dropFirst())
    self.fileSystem = fileSystem
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
    let type = try commandType(name: name)
    let options = try parseOptions(allowed: type.options)
    return type.init(options: options, fileSystem: fileSystem)
  }

  private func commandType(name: String) throws -> Command.Type {
    switch name {
    case "build": return BuildCommand.self
    default:      throw Error.invalidCommand(name)
    }
  }

  private func parseOptions(allowed: [Flag]) throws -> Options {
    let optionArguments = Array(args.dropFirst())
    return try OptionParser(args: optionArguments, allowed: allowed).parse()
  }
}
