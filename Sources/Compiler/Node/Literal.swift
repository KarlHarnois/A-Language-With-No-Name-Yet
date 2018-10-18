class Literal<A>: Node {
  let value: A

  override var attributes: [String: Any] {
    return ["value": value]
  }

  init(_ value: A) {
    self.value = value
  }
}
