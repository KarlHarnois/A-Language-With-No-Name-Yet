struct CharacterIterator {
  let prefix: String?
  let suffix: String?

  init(source: String, predicate: (String) -> Bool) {
    var prefix: String?
    var prefixLength = 0

    for c in source.characters {
      let char = String(c)

      if predicate(char) {
        prefix = (prefix ?? "") + char
        prefixLength += 1
      } else {
        break
      }
    }

    self.prefix = prefix

    let start = source.index(source.startIndex, offsetBy: prefixLength)
    let end = source.endIndex

    if start == end {
      suffix = nil
    } else {
      suffix = String(source[start..<end])
    }
  }
}
