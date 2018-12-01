import Foundation

public struct DefaultFileSystem: FileSystem {
  private let manager = FileManager.default

  public init() {}

  public func readAll(ext: String, from dir: Directory) throws -> [File] {
    var files: [File] = []

    try fileNames(atPath: dir.path).forEach { name in
      guard name.hasSuffix(ext) else { return }
      let nameWithoutExtension = name.components(separatedBy: ".")[0]
      let content = try String(contentsOfFile: dir.path + "/" + name)
      let file = File(name: nameWithoutExtension, ext: ext, content: content)
      files.append(file)
    }

    return files
  }

  public func write(_ files: [File], in dir: Directory) throws {
    try files.forEach { file in
      if !directoryExists(dir) {
        try createDirectory(dir)
      }
      let filePath = dir.urlPath(for: file)
      try file.content.write(to: filePath, atomically: true, encoding: .utf8)
    }
  }

  public func delete(_ file: File, in dir: Directory) throws {
    let path = dir.path(for: file)
    try manager.removeItem(atPath: path)
  }

  private func fileNames(atPath path: String) -> [String] {
    let enumerator = manager.enumerator(atPath: path)
    return enumerator?.allObjects as? [String] ?? []
  }

  private func directoryExists(_ dir: Directory) -> Bool {
    return manager.fileExists(atPath: dir.path)
  }

  private func createDirectory(_ dir: Directory) throws {
    try manager.createDirectory(atPath: dir.path,
                                withIntermediateDirectories: true,
                                attributes: nil)
  }
}
