public struct DefaultFileSystem: FileSystem {
  public init() {}

  public func readAll(ext: String, inDirectory dir: String) throws -> [File] {
    let dir = Directory(relativePath: dir)
    return try dir.files(ext: ext)
  }

  public func write(_ files: [File]) throws {}
}
