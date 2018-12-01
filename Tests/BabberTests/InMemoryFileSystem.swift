import BabberKit

final class InMemoryFileSystem: FileSystem {
  var files: [File] = []

  var readDirectory: String?
  var readExtension: String?

  func readAll(ext: String, inDirectory dir: String) throws -> [File] {
    readDirectory = dir
    readExtension = ext
    return files
  }

  func write(_ files: [File]) throws {
    self.files = files
  }
}
