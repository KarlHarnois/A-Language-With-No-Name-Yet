import Nimble
@testable import BabberKit

func equal(_ expected: Node) -> Predicate<Node> {
  return Predicate { actual throws -> PredicateResult in
    let json = JsonSerialization(.prettyPrinted)

    if let actual = try actual.evaluate() {
      return PredicateResult(
        bool: actual == expected,
        message: .expectedTo("equal <\(json.string(expected))>, got <\(json.string(actual))>")
      )
    } else {
      return PredicateResult(
        status: .fail,
        message: .expectedTo("equal <\(json.string(expected))>, got <nil>")
      )
    }
  }
}
