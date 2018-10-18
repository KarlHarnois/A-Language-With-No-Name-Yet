final class UnaryMessageDeclaration: Declaration {
  let selector: String

  init(selector: String, _ children: [Node]) {
    self.selector = selector
    super.init()
    self.children = children
  }
}
