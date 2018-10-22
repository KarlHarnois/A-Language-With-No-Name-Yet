import XCTest
import Nimble
@testable import Compiler

final class IteratorTests: XCTestCase {
  func testStringIterator() {
    var result = [String]()
    let iter = "Hello".iterator

    while let char = iter.next() {
      result.append(char)
    }

    expect(result) == ["H", "e", "l", "l", "o"]
  }
}
