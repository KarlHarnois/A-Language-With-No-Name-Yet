class Declaration: Node {
  convenience init(_ children: Node...) {
    self.init()
    self.children = children
  }
}
