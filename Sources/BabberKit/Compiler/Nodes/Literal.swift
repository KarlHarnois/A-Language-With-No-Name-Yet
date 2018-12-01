class Literal<A>: Node {
  let value: A

  init(_ value: A) {
    self.value = value
    super.init()
    attributes["value"] = value
  }
}
