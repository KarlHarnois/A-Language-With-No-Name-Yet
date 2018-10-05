final class NumberLiteral: Literal {
  let value: String

  override var attributes: [String: Any] {
    return ["value": value]
  }

  init(_ value: String) {
    self.value = value
  }
}
