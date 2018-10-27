final class StringProducer: NodeProducer {
  override func produce(_ opt: Options = [:]) -> Node? {
    var str = ""

    while let token = next() {
      guard token != .quote else { break }
      str += token.lexeme
    }

    return StringLiteral(str)
  }
}

