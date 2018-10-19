final class UnaryMessageDeclaration: Declaration {
  let selector: String

  override var attributes: [String: Any] {
    return ["selector": selector]
  }

  init(selector: String, _ children: [Node] = []) {
    self.selector = selector
    super.init()
    self.children = children
  }
}
