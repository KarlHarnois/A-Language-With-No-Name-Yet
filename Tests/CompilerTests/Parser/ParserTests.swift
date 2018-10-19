import XCTest
import Nimble
@testable import Compiler

class ParserTests: XCTestCase {
  var subject: Parser!
  let lexer = Lexer()

  override func setUp() {
    subject = Parser()
  }

  func testProgramDeclaration() {
    expect(self.subject.parse([])) == ProgramDeclaration()
  }

  func testNumberLiteral() {
    expect(self.subject.parse([.number("3")])) == ProgramDeclaration([
      NumberLiteral("3")
    ])
  }

  func testStringLiteral() {
    let tokens: [Token] = [
      .quote, .label("hello"), .space(1), .label("world"), .quote
    ]
    expect(self.subject.parse(tokens)) == ProgramDeclaration([
      StringLiteral("hello world")
    ])
  }

  func testUnaryMessageDeclaration() {
    let tokens = lexer.tokenize("msg get_age => 5")

    expect(self.subject.parse(tokens)) == ProgramDeclaration([
      UnaryMessageDeclaration(selector: "get_age", [
        NumberLiteral("5")
      ])
    ])
  }

  func testMultipleUnaryMessageDeclarations() {
    let tokens = lexer.tokenize("""
    msg get_age =>
      11

    msg get_name =>
      "Jean"
    """)

    expect(self.subject.parse(tokens)) == ProgramDeclaration([
      UnaryMessageDeclaration(selector: "get_age", [
        NumberLiteral("11")
      ]),
      UnaryMessageDeclaration(selector: "get_name", [
        StringLiteral("Jean")
      ])
    ])
  }

  func testBinaryMessageDeclaration() {}
  func testKeywordMessageDeclaration() {}
}

