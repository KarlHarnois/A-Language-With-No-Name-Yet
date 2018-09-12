import Quick
import Nimble
@testable import Compiler

class IntExtensionSpec: QuickSpec {
  override func spec() {
    describe("times") {
      it("returns the correct value") {
        expect(5.times { 1 }) == [1, 1, 1, 1, 1]
      }
    }
  }
}
