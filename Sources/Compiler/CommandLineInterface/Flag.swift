enum Flag: String, CaseIterable {
  case target

  func match(_ str: String) -> Bool {
    return "--" + rawValue == str || "-" + rawValue[0] == str
  }
}
