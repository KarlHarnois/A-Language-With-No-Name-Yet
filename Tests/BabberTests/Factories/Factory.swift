protocol Factory {
  static func createInstance() -> Self
}

extension Factory {
  static func createList(_ count: Int) -> [Self] {
    return (0...count).map { _ in createInstance() }
  }
}
