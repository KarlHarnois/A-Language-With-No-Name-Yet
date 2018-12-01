import XCTest
import Nimble
@testable import BabberKit

class StringExtensionTests: XCTestCase {
  func testSubscript() {
    expect("123"[2]) == "3"
  }

  func testTrueMatch() {
    expect("123".match("[0-9]")) == true
  }

  func testFalseMatch() {
    expect("abc".match("[0-9]")) == false
  }
}
