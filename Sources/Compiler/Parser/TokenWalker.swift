final class TokenWalker {
  private let iter: Iterator<[Token]>

  init(_ iter: Iterator<[Token]>) {
    self.iter = iter
  }

  func walk() -> Node? {
    guard let token = iter.next() else {
      return nil
    }
    switch token {
    case .number(let value):
      return NumberLiteral(value)
    case .quote:
      return createString()
    case .label("msg"):
      return createMessage()
    default:
      return nil
    }
  }

  private func createString() -> StringLiteral {
    var str = ""
    while let token = iter.next() {
      guard token != .quote else { break }
      str += token.lexeme
    }
    return StringLiteral(str)
  }

  private func createMessage() -> Node {
    let msg = UnaryMessageDeclaration(selector: createSelector())
    while !iter.isDone {
      guard iter.current != .label("msg") else { break }
      if let node = walk() {
        msg.add(node)
      }
    }
    return msg
  }

  private func createSelector() -> String {
    var selector = ""
    while let token = iter.next() {
      if case .space = token { continue }
      guard token != .operator("=>") else { break }
      selector += token.lexeme
    }
    return selector
  }
}
