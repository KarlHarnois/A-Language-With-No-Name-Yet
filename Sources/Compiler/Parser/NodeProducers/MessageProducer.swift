final class MessageProducer: NodeProducer {
  override func produce(_ opt: Options = [:]) -> Node? {
    let msg = UnaryMessageDeclaration(selector: produceSelector())

    while hasNext {
      if hasExitedMessage { break }
      guard let node = walk() else { continue }
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

  private var hasExitedMessage: Bool {
    return current == .label("msg") || current == .label("class")
  }
}
