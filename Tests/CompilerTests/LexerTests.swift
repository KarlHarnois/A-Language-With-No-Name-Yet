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

  func testSubsequentNewlines() {
    let input = """



    """
    expect(self.subject.tokenize(input)) == [.newline, .newline]
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

  func testSubsequentParens() {
    expect(self.subject.tokenize("(())")) == [.openParen, .openParen, .closeParen, .closeParen]
  }

  func testSquareBrackets() {
    expect(self.subject.tokenize("[]")) == [.openSquare, .closeSquare]
  }

  func testSubsequentSquareBracket() {
    expect(self.subject.tokenize("[[]]")) == [.openSquare, .openSquare, .closeSquare, .closeSquare]
  }

  func testCurlyBrackets() {
    expect(self.subject.tokenize("{}")) == [.openCurly, .closeCurly]
  }

  func testSubsequentCurlyBrackets() {
    expect(self.subject.tokenize("{{}}")) == [.openCurly, .openCurly, .closeCurly, .closeCurly]
  }

  func testDot() {
    expect(self.subject.tokenize("1.4")) == [.number("1"), .dot, .number("4")]
  }

  func testSubsequentDots() {
    expect(self.subject.tokenize("...")) == [.dot, .dot, .dot]
  }

  func testComma() {
    expect(self.subject.tokenize(",")) == [.comma]
  }

  func testSubsequentComma() {
    expect(self.subject.tokenize(",,,,")) == [.comma, .comma, .comma, .comma]
  }
}
