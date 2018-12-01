import XCTest
import Nimble
@testable import BabberKit

final class DefaultFileSystemTests: XCTestCase {
  var fs: DefaultFileSystem!
  let fixtureDir = Directory(relativePath: "/Tests/BabberTests/Files/Fixtures")

  override func setUp() {
    super.setUp()
    fs = DefaultFileSystem()
  }

  func write(_ file: File) {
    try? fs.write([file], in: fixtureDir)
  }

  func delete(_ file: File) {
    try? fs.delete(file, in: fixtureDir)
  }

  func readFiles(ext: String) -> [File] {
    let files = try? fs.readAll(ext: ext, from: fixtureDir)
    return files ?? []
  }

  func testReadFiles() {
    let files = readFiles(ext: "txt")

    expect(files.count) == 2
    expect(files.map { $0.name }) == ["Animal", "Robot"]
    expect(files.map { $0.content }) == ["Tigo\n", "Bipboop\n"]
  }

  func testWriteFiles() {
    let file = File.create(name: "Human", ext: "json", content: "Karl")

    write(file)
    expect(self.readFiles(ext: "json")).to(contain(file))
    delete(file)
  }

  func testDeleteFile() {
    let file = File.create(name: "Robot", ext: "json", content: "Karl")

    write(file)
    delete(file)
    expect(self.readFiles(ext: "json")).toNot(contain(file))
  }
}
