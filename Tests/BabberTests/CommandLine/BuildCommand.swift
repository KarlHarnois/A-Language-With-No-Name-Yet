import XCTest
import Nimble
@testable import BabberKit

final class BuildCommandTests: CommandTests {
  func testMissingTarget() {
    run("build")
    expect(self.error) == .missingRequiredOption(.target)
  }

  func testInvalidTarget() {
    run("build --target js")
    expect(self.error) == .invalidOption(.target, "js")
  }

  func testShorthandTarget() {
    run("build -t clr")
    expect(self.error) == .invalidOption(.target, "clr")
  }

  func testUnknownOption() {
    run("build --toaster old")
    expect(self.error) == .unknownOption("--toaster")
  }

  func testMissingValueForTarget() {
    run("build --target")
    expect(self.error) == .missingValue(.target)
  }
}
