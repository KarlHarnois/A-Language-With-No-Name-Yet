public protocol FileSystem {
  func readAll(ext: String, inDirectory dir: String) throws -> [File]
  func write(_ files: [File]) throws
}
