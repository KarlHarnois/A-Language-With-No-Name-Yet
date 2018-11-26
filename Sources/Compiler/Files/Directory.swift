import Foundation

struct Directory {
  let path: String

  init(path: String) {
    self.path = path
  }

  init(relativePath: String) {
    let currentDirPath = FileManager.default.currentDirectoryPath
    let path = currentDirPath + relativePath
    self.init(path: path)
  }

  func files(ext: String) throws -> [File] {
    var files: [File] = []

    try fileNames.forEach { name in
      guard name.hasSuffix(ext) else { return }
      let nameWithoutExtension = name.components(separatedBy: ".")[0]
      let content = try String(contentsOfFile: path + "/" + name)
      let file = File(name: nameWithoutExtension, ext: ext, content: content)
      files.append(file)
    }

    return files
  }

  private var fileNames: [String] {
    let manager = FileManager.default
    let enumerator = manager.enumerator(atPath: path)
    return enumerator?.allObjects as? [String] ?? []
  }
}
