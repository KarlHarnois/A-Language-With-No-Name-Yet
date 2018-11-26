import XCTest
import Nimble
@testable import Compiler

final class DirectoryTests: XCTestCase {
  let fixturePath = "/Tests/CompilerTests/Files/Fixtures"

  func testFilesFromRelativePath() {
    let dir = Directory(relativePath: fixturePath)
    let files = try? dir.files(ext: "txt")

    expect(files?.count) == 2
    expect(files?.map { $0.name }) == ["Animal", "Robot"]
    expect(files?.map { $0.content }) == ["Tigo\n", "Bipboop\n"]
  }
}
