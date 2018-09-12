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
}
