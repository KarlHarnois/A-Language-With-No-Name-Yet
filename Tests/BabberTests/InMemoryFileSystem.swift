import BabberKit

final class InMemoryFileSystem: FileSystem {
  private typealias Path = String
  private var system: [Path: (dir: Directory, files: [File])] = [:]

  func readAll(ext: String, from dir: Directory) throws -> [File] {
    let files = system[dir.path]?.files ?? []
    return files.filter { $0.ext == ext }
  }

  func write(_ files: [File], in dir: Directory) throws {
    guard let content = system[dir.path] else {
      system[dir.path] = (dir: dir, files: files)
      return
    }
    system[dir.path] = (dir: dir, files: content.files + files)
  }

  func delete(_ file: File, in dir: Directory) throws {
  }
}
