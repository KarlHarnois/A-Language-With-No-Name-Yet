final class MessageProducer: NodeProducer {
  override func produce() -> Node? {
    let msg = UnaryMessageDeclaration(selector: produceSelector())

    while !isDoneIterating {
      guard current != .label("msg"), current != .label("class") else { break }
      if let node = walk() {
        msg.add(node)
      }
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
}
