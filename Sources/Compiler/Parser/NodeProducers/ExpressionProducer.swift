
final class ExpressionProducer: NodeProducer {
  override func produce(_ opt: Options = [:]) -> Node? {
    guard let variableName = opt["label"] as? String else {
      return nil
    }
    let variable = InstanceVariable(variableName)
    let tokens = produceMessageTokens()

    if tokens.isEmpty {
      return variable
    } else {
      return parseMessages(tokens, rootVar: variable)
    }
  }

  private func produceMessageTokens() -> [Token] {
    var tokens: [Token] = []
    while let token = next() {
      if token == .newline { break }
      if case .space = token { continue }
      tokens.append(token)
    }
    return tokens
  }

  private func parseMessages(_ tokens:  [Token], rootVar: Node) -> Node? {
    var node: Node?

    tokens.forEach { token in
      guard case .label(let selector) = token else {
        return
      }
      if let receiver = node {
        let newNode = SendExpression(selector: selector, receiver: receiver, params: [])
        node = newNode
      } else {
        node = SendExpression(selector: selector, receiver: rootVar, params: [])
      }
    }

    return node
  }
}
