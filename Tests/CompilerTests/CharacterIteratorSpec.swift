import Quick
import Nimble
@testable import Compiler

class CharacterIteratorSpec: QuickSpec {
  override func spec() {
    describe("prefix") {
      context("when prefix match predicate") {
        it("returns the prefix") {
          let iterator = CharacterIterator(source: "  1234  ", predicate: { $0 == " " })
          expect(iterator.prefix) == "  "
        }
      }

      context("when prefix doesn't match predicate") {
        it("returns nil") {
          let iterator = CharacterIterator(source: "  adff  ", predicate: { $0 == "a" })
          expect(iterator.prefix).to(beNil())
        }
      }

      context("when entire source match prefix") {
        it("returns the source") {
          let source = "           "
          let iterator = CharacterIterator(source: source, predicate: { $0 == " " })
          expect(iterator.prefix) == source
        }
      }
    }

    describe("suffix") {
      context("when part of the string matches the predicate") {
        it("returns the rest") {
          let iterator = CharacterIterator(source: "1111a 222", predicate: { $0 == "1" })
          expect(iterator.suffix) == "a 222"
        }
      }

      context("when the prefix is nil") {
        it("returns the source") {
          let source = "  aaa     "
          let iterator = CharacterIterator(source: source, predicate: { $0 == "a" })
          expect(iterator.suffix) == source
        }
      }

      context("when the entire source matches the predicate") {
        it("returns nil") {
          let iterator = CharacterIterator(source: "aaaaaaa", predicate: { $0 == "a" })
          expect(iterator.suffix).to(beNil())
        }
      }
    }
  }
}
