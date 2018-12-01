public struct File {
  public let name: String
  public let ext: String
  public let content: String

  var fullname: String {
    return name + "." + ext
  }
}

extension File: Equatable {
  public static func == (left: File, right: File) -> Bool {
    return left.name == right.name
      && left.ext == right.ext
      && left.content == right.content
  }
}
