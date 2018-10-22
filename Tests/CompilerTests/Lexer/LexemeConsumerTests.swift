import Nimble
import XCTest
@testable import Compiler

final class LexemeConsumerTests: XCTestCase {
  func testConsumeLexeme() {
    let subject = LexemeConsumer(iterator: ";;;foo".iterator)
    expect(subject.consumeLexeme(where: { $0 == ";" })) == ";;;"
  }

  func testMaxSize() {
    let subject = LexemeConsumer(iterator: "...".iterator)
    expect(subject.consumeLexeme(maxSize: 1, where: { $0 == "." })) == "."
  }

  func testSubsequentLexemes() {
    let subject = LexemeConsumer(iterator: "123".iterator)

    let lexemes = [
      subject.consumeLexeme(where: { $0 == "1" }),
      subject.consumeLexeme(where: { $0 == "2" }),
      subject.consumeLexeme(where: { $0 == "3" }),
      subject.consumeLexeme(where: { $0 == "4" })
    ]

    expect(lexemes) == ["1", "2", "3", nil]
  }
}
