final class ClassDeclaration: Declaration {
  let name: String

  init(name: String, _ children: [Node] = []) {
    self.name = name
    super.init()
    self.children = children
    attributes["name"] = name
  }
}
