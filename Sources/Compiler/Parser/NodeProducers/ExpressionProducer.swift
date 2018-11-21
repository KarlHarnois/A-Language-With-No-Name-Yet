
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
    switch tokens[0] {
    case .label(let selector):
      return SendExpression(selector: selector, receiver: rootVar, params: [])
    default:
      return nil
    }
  }
}
