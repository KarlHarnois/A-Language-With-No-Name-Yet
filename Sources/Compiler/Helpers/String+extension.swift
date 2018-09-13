extension String {
  var iterator: StringIterator {
    return StringIterator(self)
  }

  subscript (i: Int) -> String {
    return String(self[index(startIndex, offsetBy: i)])
  }

  func match(_ regex: String) -> Bool {
    return range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
  }
}
