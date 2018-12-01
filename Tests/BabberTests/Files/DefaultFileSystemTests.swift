import XCTest
import Nimble
@testable import BabberKit

final class DefaultFileSystemTests: XCTestCase {
  let describedType = DefaultFileSystem.self
  let fixturePath = "/Tests/BabberTests/Files/Fixtures"

  func testFilesFromRelativePath() {
    let dir = Directory(relativePath: fixturePath)
    let fs = describedType.init()
    let files = try? fs.readAll(ext: "txt", from: dir)

    expect(files?.count) == 2
    expect(files?.map { $0.name }) == ["Animal", "Robot"]
    expect(files?.map { $0.content }) == ["Tigo\n", "Bipboop\n"]
  }
}
