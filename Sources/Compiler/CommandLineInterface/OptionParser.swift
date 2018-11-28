struct OptionParser {
  let iterator: Iterator<[String]>

  init(args: [String]) {
    iterator = Iterator(iterable: args)
  }

  func parse(allowed: [Flag] = Flag.allCases) throws -> [Flag: String] {
    var options: [Flag: String] = [:]

    while let optionString = iterator.next() {
      guard let flag = allowed.first(where: { $0.match(optionString) }) else {
        break
      }
      guard let option = iterator.next() else {
        break
      }
      options[flag] = option
    }

    return options
  }
}
