struct Lexer {
  func tokenize(_ source: String) -> [Token] {
    var tokens: [Token] = []
    var remainder = source

    while !remainder.isEmpty {
      let (token, rem) = consume(remainder)
      if let token = token {
        tokens.append(token)
      }
      remainder = rem ?? ""
    }

    return tokens
  }

  private func consume(_ source: String) -> (token: Token?, remainder: String?) {
    var token: Token?
    var remainder: String?
    var i = 0

    while token == nil || i == consumers.count + 1 {
      (token, remainder) = consumers[i].consume(source)
      i += 1
    }

    return (token, remainder)
  }

  private var consumers: [CharConsumer] {
    return [spaceConsumer, numberConsumer]
  }

  private let spaceConsumer = CharConsumer(
    predicate: { $0 == " " },
    map: { .space($0.count) }
  )

  private let numberConsumer = CharConsumer(
    predicate: { Int($0) != nil },
    map: { .number($0) }
  )
}


struct CharConsumer {
  let predicate: (String) -> Bool
  let map: (String) -> Token

  func consume(_ source: String) -> (token: Token?, remainder: String?) {
    let iterator = CharacterIterator(source: source, predicate: predicate)
    return (iterator.prefix.map(map), iterator.suffix)
  }
}
