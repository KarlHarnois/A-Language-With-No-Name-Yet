final class ClassDeclaration: Declaration {
  let name: String

  init(name: String) {
    self.name = name
    super.init()
    attributes["name"] = name
  }
}
