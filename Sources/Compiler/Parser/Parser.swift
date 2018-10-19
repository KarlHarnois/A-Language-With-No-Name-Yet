struct Parser {
  func parse(_ tokens: [Token]) -> Node {
    let program = ProgramDeclaration()
    let walker = TokenWalker(tokens)

    while let node = walker.walk() {
      program.add(node)
    }

    return program
  }
}

final class TokenWalker {
  private let iter: TokenIterator

  init(_ tokens: [Token]) {
    iter = .init(tokens)
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

final class TokenIterator {
  private let tokens: [Token]
  private(set) var cursor = 0

  init(_ tokens: [Token]) {
    self.tokens = tokens
  }

  @discardableResult
  func next() -> Token? {
    guard !isDone else { return nil }
    defer { cursor += 1 }
    return current
  }

  var isDone: Bool {
    return cursor >= tokens.count
  }

  var current: Token {
    return tokens[cursor]
  }
}
