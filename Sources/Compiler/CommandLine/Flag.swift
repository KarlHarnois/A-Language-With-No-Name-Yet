enum Flag: String, CaseIterable {
  case target

  var requiresValue: Bool {
    switch self {
    case .target: return true
    }
  }

  var verbose: String {
    return "--" + rawValue
  }

  var shorthand: String {
    return "-" + rawValue[0]
  }

  func match(_ str: String) -> Bool {
    return verbose == str || shorthand == str
  }
}
