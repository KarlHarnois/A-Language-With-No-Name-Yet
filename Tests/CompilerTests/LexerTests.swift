import XCTest
import Nimble
@testable import Compiler

class LexerTests: XCTestCase {
  var subject: Lexer!

  override func setUp() {
    subject = Lexer()
  }

  func testSpace() {
    expect(self.subject.tokenize("  ")) == [.space(2)]
  }

  func testNumber() {
    expect(self.subject.tokenize("34")) == [.number("34")]
  }

  func testSpaceAndNumber() {
    expect(self.subject.tokenize("2  33 ")) == [.number("2"), .space(2), .number("33"), .space(1)]
  }

  func testNewline() {
    let input = """
    123
    445
    """
    expect(self.subject.tokenize(input)) == [.number("123"), .newline, .number("445")]
  }

  func testOperator() {
    expect(self.subject.tokenize("1 + 2")) == [.number("1"), .space(1), .operator("+"), .space(1), .number("2")]
  }

  func testMultiCharsOperator() {
    expect(self.subject.tokenize("&&")) == [.operator("&&")]
  }

  func testParens() {
    expect(self.subject.tokenize("(1)")) == [.openParen, .number("1"), .closeParen]
  }

  func testSquareBrackets() {
    expect(self.subject.tokenize("[]")) == [.openSquare, .closeSquare]
  }

  func testCurlyBrackets() {
    expect(self.subject.tokenize("{}")) == [.openCurly, .closeCurly]
  }
}
