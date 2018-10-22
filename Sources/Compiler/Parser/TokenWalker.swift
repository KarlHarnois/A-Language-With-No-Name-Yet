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
    case .label("class"):
      return createClass()
    default:
      return nil
    }
  }

  private func advance(to token: Token) {
    while let t = iter.next() {
      if t == token { break }
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

  private func createClass() -> Node? {
    guard let name = createClassName() else {
      return nil
    }
    let classNode = ClassDeclaration(name: name)

    while !iter.isDone {
      guard iter.current != .label("class") else { break }
      if let node = walk() {
        classNode.add(node)
      }
    }

    return classNode
  }

  private func createClassName() -> String? {
    var name: String?

    while let token = iter.next() {
      if name != nil {
        advance(to: .operator("=>"))
        break
      } else if case .label(let value) = token {
        name = value
      }
    }

    return name
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
