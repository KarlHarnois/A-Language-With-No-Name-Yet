import XCTest
import Nimble
@testable import BabberKit

final class DirectoryTests: XCTestCase {
  func testPath() {
    let file = File.create(name: "user_controller", ext: "rb")
    let dir = Directory(relativePath: "/src")
    let expected = "/src/user_controller.rb"

    expect(dir.path(for: file)).to(endWith(expected))
    expect(dir.urlPath(for: file).absoluteString).to(endWith(expected))
  }
}
