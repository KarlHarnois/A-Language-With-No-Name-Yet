import XCTest
import Nimble
@testable import BabberKit

final class CommandLineInterfaceTests: CommandTests {
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
}
