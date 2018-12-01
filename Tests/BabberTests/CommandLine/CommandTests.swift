import XCTest
import Nimble
@testable import BabberKit

class CommandTests: XCTestCase {
  var error: BabberKit.Error?

  func run(_ args: String) {
    do {
      let args = ["CliName"] + args.split(separator: " ").map(String.init)
      try CommandLineInterface(args: args, fileSystem: InMemoryFileSystem()).run()
    } catch {
      self.error = error as? BabberKit.Error
    }
  }

  override func setUp() {
    super.setUp()
    error = nil
  }
}
