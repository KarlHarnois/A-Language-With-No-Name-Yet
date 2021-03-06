import XCTest
import Nimble
@testable import BabberKit

class TokenTests: XCTestCase {
  func testEqualSpaces() {
    expect(Token.space(2)) == Token.space(2)
  }

  func testUnequalSpaces() {
    expect(Token.space(1)) != Token.space(2)
  }

  func testEqualNumber() {
    expect(Token.number("2")) == Token.number("2")
  }

  func testUnequalNumber() {
    expect(Token.number("1")) != Token.number("3")
  }

  func testEqualOperator() {
    expect(Token.operator("*")) == Token.operator("*")
  }

  func testUnequalOperator() {
    expect(Token.operator("-")) != Token.operator("||")
  }

  func testDifferentParen() {
    expect(Token.openParen) != Token.closeParen
  }

  func testDifferentSquareBrackets() {
    expect(Token.openSquare) != Token.closeSquare
  }

  func testDifferentCurlyBrackets() {
    expect(Token.openCurly) != Token.closeCurly
  }

  func testSpaceLexeme() {
    expect(Token.space(4).lexeme) == "    "
  }

  func testWhitespace() {
    let tokens: [Token] = [.space(2), .newline, .number("2")]
    expect(tokens.map { $0.isWhitespace }) == [true, true, false]
  }
}
