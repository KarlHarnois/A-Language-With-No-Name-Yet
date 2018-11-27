import Foundation

public struct CommandLineInterface {
  private let args: [String]

  public init(args: [String] = CommandLine.arguments) {
    self.args = args
  }

  public func run() throws {
  }
}
