final class ExpressionProducer: NodeProducer {
  override func produce(_ opt: Options = [:]) -> Node? {
    guard let variableName = opt["label"] as? String else {
      return nil
    }

    var tokens: [Token] = []

    while let token = next() {
      if token == .newline { break }
      if case .space = token { continue }
      tokens.append(token)
    }

    if tokens.isEmpty {
      return InstanceVariable(variableName)
    }

    return nil
  }
}
