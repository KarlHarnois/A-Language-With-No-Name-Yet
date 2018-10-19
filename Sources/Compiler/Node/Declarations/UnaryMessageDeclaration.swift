final class UnaryMessageDeclaration: MessageDeclaration {
  init(selector: String, _ children: [Node] = []) {
    super.init(selector: selector)
    self.children = children
  }
}
