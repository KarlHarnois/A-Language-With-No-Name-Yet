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
    expect(self.subject.parse([.number("3")])) == ProgramDeclaration(NumberLiteral("3"))
  }

  func testUnaryMessageExpression() {
  }

  func testBinaryMessageExpression() {
  }

  func testKeywordMessageExpression() {
  }
}

