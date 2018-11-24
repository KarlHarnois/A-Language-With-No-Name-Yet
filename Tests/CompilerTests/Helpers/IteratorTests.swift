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

  func testElementSteps() {
    let tokens: [Token] = [.space(3), .number("4"), .newline]
    let iter = tokens.iterator
    expect(iter.element(steps: 2)) == .newline
    expect(iter.element(steps: 10)).to(beNil())
  }
}
