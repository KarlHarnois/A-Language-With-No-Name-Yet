public protocol FileSystem {
  func readAll(ext: String, from dir: Directory) throws -> [File]
  func write(_ files: [File], in dir: Directory) throws
}
