final class StringProducer: NodeProducer {
  override func produce() -> Node? {
    var str = ""

    while let token = next() {
      guard token != .quote else { break }
      str += token.lexeme
    }

    return StringLiteral(str)
  }
}

