final class AssignmentStatement: Statement {
  let variableName: String
  let value: Node

  init(variableName: String, value: Node) {
    self.variableName = variableName
    self.value = value
    super.init()
    attributes["variableName"] = variableName
    attributes["value"] = value.serialized
  }
}
