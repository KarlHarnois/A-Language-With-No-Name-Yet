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
    switch current {
    case .number(let value):
      next()
      return NumberLiteral(value)
    case .quote:
      next()
      return createString()
    default:
      fatalError()
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

  private var current: Token {
    return tokens[cursor]
  }

  private func next() {
    cursor += 1
  }
}
