extension Int {
  func times<A>(_ function: @escaping () -> A) -> [A] {
    return (1...self).map { _ in function() }
  }
}
