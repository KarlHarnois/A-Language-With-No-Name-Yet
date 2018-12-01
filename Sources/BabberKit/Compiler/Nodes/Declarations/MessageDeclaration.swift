class MessageDeclaration: Declaration {
  let selector: String

  init(selector: String) {
    self.selector = selector
    super.init()
    attributes["selector"] = selector
  }
}
