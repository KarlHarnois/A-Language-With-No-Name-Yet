@testable import BabberKit

extension File: Factory {
  static func create(name: String = "controller",
                     ext: String = "babber",
                     content: String = "some content") -> File {
    return .init(name: name, ext: ext, content: content)
  }

  static func createInstance() -> File {
    return .create()
  }
}
