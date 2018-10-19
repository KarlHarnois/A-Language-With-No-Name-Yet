struct Parser {
  func parse(_ tokens: [Token]) -> Node {
    let program = ProgramDeclaration()
    let walker = TokenWalker(tokens)

    while !walker.isDone {
      if let node = walker.walk() {
        program.add(node)
      }
    }

    return program
  }
}

final class TokenWalker {
  private let tokens: [Token]
  private var cursor = 0

  init(_ tokens: [Token]) {
    self.tokens = tokens
  }

  var isDone: Bool {
    return cursor >= tokens.count
  }

  func walk() -> Node? {
    let token = current
    next()
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
    while current != .quote {
      str += current.lexeme
      next()
    }
    next()
    return StringLiteral(str)
  }

  private func createMessage() -> Node {
    let msg = UnaryMessageDeclaration(selector: createSelector())

    while !isDone {
      guard current != .label("msg") else { break }
      if let node = walk() {
        msg.add(node)
      }
    }

    return msg
  }

  private func createSelector() -> String {
    var selector = ""
    while !isDone {
      ignoreSpaces()
      guard current != .operator("=>") else { break }
      selector += current.lexeme
      next()
    }
    return selector
  }

  private func ignoreSpaces() {
    while case .space = current {
      next()
    }
  }

  private var current: Token {
    return tokens[cursor]
  }

  private func next() {
    cursor += 1
  }
}
