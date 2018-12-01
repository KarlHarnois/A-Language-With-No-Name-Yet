final class FileDeclaration: Declaration {
  let name: String

  init(name: String, _ children: [Node] = []) {
    self.name = name
    super.init()
    attributes["name"] = name
    self.children = children
  }
}
