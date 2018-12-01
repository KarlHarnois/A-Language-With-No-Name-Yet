import Foundation

public struct DefaultFileSystem: FileSystem {
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
  }

  private func fileNames(atPath path: String) -> [String] {
    let manager = FileManager.default
    let enumerator = manager.enumerator(atPath: path)
    return enumerator?.allObjects as? [String] ?? []
  }
}
