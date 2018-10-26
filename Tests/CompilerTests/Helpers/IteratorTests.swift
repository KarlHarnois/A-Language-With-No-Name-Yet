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

  func testTrimWhitespaces() {
    let tokens: [Token] = [.space(2), .newline, .number("3")]
    let iter = tokens.iterator
    iter.trimWhitespaces()
    expect(iter.next()) == .number("3")
  }
}
