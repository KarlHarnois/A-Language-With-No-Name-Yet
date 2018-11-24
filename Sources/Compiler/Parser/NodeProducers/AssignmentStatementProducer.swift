final class AssignmentProducer: NodeProducer {
  override func produce(_ opt: Options = [:]) -> Node? {
    guard let variableName = opt["variableName"] as? String,
          let value = produceValue()
          else { return nil }
    return AssignmentStatement(variableName: variableName, value: value)
  }

  private func produceValue() -> Node? {
    while hasNext {
      guard let node = walk() else { continue }
      return node
    }
    return nil
  }
}
