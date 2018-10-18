class ProgramDeclaration: Declaration {
  init(_ children: [Node] = []) {
    super.init()
    self.children = children
  }
}
