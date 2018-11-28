import XCTest
import Nimble
@testable import Compiler

final class CommandLineInterfaceTests: XCTestCase {
  var error: Compiler.Error?

  func run(_ args: String) {
    do {
      let args = ["CliName"] + args.split(separator: " ").map(String.init)
      try CommandLineInterface(args: args, fileSystem: InMemoryFileSystem()).run()
    } catch {
      self.error = error as? Compiler.Error
    }
  }

  override func setUp() {
    super.setUp()
    error = nil
  }

  func testWithoutArguments() {
    run("")
    expect(self.error) == .custom("help command not implemented yet")
  }

  func testHelp() {
    run("help")
    expect(self.error) == .custom("help command not implemented yet")
  }

  func testInvalidCommand() {
    run("make coffee")
    expect(self.error) == .invalidCommand("make")
  }

  func testMissingRequiredOption() {
    run("build")
    expect(self.error) == .missingRequiredOption(.target)
  }

  func testInvalidOption() {
    run("build --target js")
    expect(self.error) == .invalidOption(.target, "js")
  }

  func testShorthandFlag() {
    run("build -t clr")
    expect(self.error) == .invalidOption(.target, "clr")
  }

  func testUnknownOption() {
    run("build --toaster old")
    expect(self.error) == .unknownOption("--toaster")
  }

  func testMissingValueForOption() {
    run("build --target")
    expect(self.error) == .missingValue(.target)
  }
}
