import Nimble
@testable import Compiler

func equal(_ expected: Node) -> Predicate<Node> {
  return Predicate { actual throws -> PredicateResult in
    if let actual = try actual.evaluate() {
      return PredicateResult(
        bool: actual == expected,
        message: .expectedTo("equal <\(expected.stringRepresentation)>, got <\(actual.stringRepresentation)>")
      )
    } else {
      return PredicateResult(
        status: .fail,
        message: .expectedTo("equal <\(expected.stringRepresentation)>, got <nil>")
      )
    }
  }
}
