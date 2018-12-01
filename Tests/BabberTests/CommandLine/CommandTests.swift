import XCTest
import Nimble
@testable import BabberKit

class CommandTests: XCTestCase {
  var error: BabberKit.Error?
  var fileSystem = InMemoryFileSystem()

  func run(_ args: String) {
    do {
      let args = ["CliName"] + args.split(separator: " ").map(String.init)
      try CommandLineInterface(args: args, fileSystem: fileSystem).run()
    } catch {
      self.error = error as? BabberKit.Error
    }
  }

  func write(_ file: File, in dir: Directory) {
    write([file], in: dir)
  }

  func write(_ files: [File], in dir: Directory) {
    try? fileSystem.write(files, in: dir)
  }

  override func setUp() {
    super.setUp()
    error = nil
    fileSystem = InMemoryFileSystem()
  }
}
