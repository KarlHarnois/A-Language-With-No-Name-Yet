import Quick
import Nimble
@testable import Compiler

class StringExtensionSpec: QuickSpec {
  override func spec() {
    describe("subscript") {
      it("returns the correct character") {
        expect("123"[2]) == "3"
      }
    }

    describe("match") {
      let regex = "[0-9]"

      it("returns true if string match the regex") {
        expect("134".match(regex)) == true
      }

      it("returns false if the string doesn't match the regex") {
        expect("abc".match(regex)) == false
      }
    }
  }
}
