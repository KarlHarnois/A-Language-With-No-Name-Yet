import XCTest
import Nimble
@testable import BabberKit

final class BuildCommandTests: CommandTests {
  let src = Directory(relativePath: "/src")

  var buildFiles: [File] {
    let dir = Directory(relativePath: "/.build")
    let files = try? self.fileSystem.readAll(ext: "class", from: dir)
    return files ?? []
  }

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

  func testJVMTargetExists() {
    run("build --target jvm")
    expect(self.error).to(beNil())
  }

  func testGenerateClassFiles() {
    let file = File.create(ext: "babber")
    write(file, in: src)
    run("build --target jvm")
    expect(self.buildFiles.count) == 1
  }
}
