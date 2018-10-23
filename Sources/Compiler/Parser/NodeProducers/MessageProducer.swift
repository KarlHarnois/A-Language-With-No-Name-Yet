final class MessageProducer: NodeProducer {
  override func produce() -> Node? {
    let msg = UnaryMessageDeclaration(selector: produceSelector())

    while hasNext {
      guard let node = walk(until: hasExitedMessage) else {
        break
      }
      msg.add(node)
    }

    return msg
  }

  private func produceSelector() -> String {
    var selector = ""

    while let token = next() {
      if case .space = token { continue }
      guard token != .operator("=>") else { break }
      selector += token.lexeme
    }

    return selector
  }

  private func hasExitedMessage(token: Token) -> Bool {
    return token == .label("msg") || token == .label("class")
  }
}
