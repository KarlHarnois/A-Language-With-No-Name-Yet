import Foundation

struct Directory {
  let path: String

  private let pathURL: URL

  init(path: String) {
    self.path = path
    self.pathURL = URL(fileURLWithPath: path)
  }

  init(relativePath: String) {
    let currentDirPath = FileManager.default.currentDirectoryPath
    let path = currentDirPath + relativePath
    self.init(path: path)
  }

  func files(ext: String) throws -> [File] {
    let manager = FileManager.default
    let enumerator = manager.enumerator(atPath: path)

    var files: [File] = []

    try enumerator?.allObjects.forEach { elem in
      guard let elem = elem as? String, elem.hasSuffix(ext) else { return }
      let name = elem.components(separatedBy: ".")[0]
      let content = try String(contentsOfFile: path + "/" + elem)
      let file = File(name: name, ext: ext, content: content)
      files.append(file)
    }

    return files
  }
}
