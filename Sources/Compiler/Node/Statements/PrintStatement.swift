final class PrintStatement: Statement {
  init(_ children: [Node]) {
    super.init()
    self.children = children
  }
}
