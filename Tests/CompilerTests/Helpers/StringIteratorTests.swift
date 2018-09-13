import XCTest
import Nimble
@testable import Compiler

class StringIteratorTests: XCTestCase {
  var subject: StringIterator!

  override func setUp() {
    subject = StringIterator("123")
  }

  func testCurrent() {
    subject.next()
    expect(self.subject.current) == "2"
  }

  func testNext() {
    subject.next()
    expect(self.subject.current) == "2"
  }

  func testHasNextWhenTrue() {
    subject.next()
    expect(self.subject.hasNext) == true
  }

  func testHasNextWhenFalse() {
    subject.next()
    subject.next()
    expect(self.subject.hasNext) == false
  }

  func testIsDoneWhenTrue() {
    subject.next()
    subject.next()
    subject.next()
    expect(self.subject.isDone) == true
  }

  func testIsDoneWhenFalse() {
    subject.next()
    subject.next()
    expect(self.subject.isDone) == false
  }

  func testConsumeLexeme() {
    expect(self.subject.consumeLexeme(where: { $0.match("[0-9]") })) == "123"
  }

  func testConsumeLexemeMoveCurrent() {
    _ = subject.consumeLexeme(where: { $0 == "1" || $0 == "2"})
    expect(self.subject.current) == "3"
  }
}
