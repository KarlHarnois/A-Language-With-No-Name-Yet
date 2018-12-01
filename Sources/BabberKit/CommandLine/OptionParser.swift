typealias Options = [Flag: String?]

struct OptionParser {
  let iterator: Iterator<[String]>
  let allowed: [Flag]

  init(args: [String], allowed: [Flag]) {
    self.iterator = Iterator(iterable: args)
    self.allowed = allowed
  }

  func parse() throws -> Options {
    var options: Options = [:]

    while let optionString = iterator.next() {
      guard let flag = allowed.first(where: { $0.match(optionString) }) else {
        throw Error.unknownOption(optionString)
      }
      guard flag.requiresValue else {
        options[flag] = nil
        continue
      }
      guard let value = iterator.next() else {
        throw Error.missingValue(flag)
      }
      options[flag] = value
    }

    return options
  }
}
