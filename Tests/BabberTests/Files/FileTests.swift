import XCTest
import Nimble
@testable import BabberKit

final class FileTests: XCTestCase {
  let file = File.self

  func testEquality() {
    expect(self.file.create(name: "controller")) != .create(name: "model")
    expect(self.file.create(ext: "swift")) != .create(ext: "rb")
    expect(self.file.create(content: "hello")) != .create(content: "world")
    expect(self.file.create()) == .create()
  }

  func testFullname() {
    let actual = file.create(name: "controller", ext: "swift")
    expect(actual.fullname) == "controller.swift"
  }
}
