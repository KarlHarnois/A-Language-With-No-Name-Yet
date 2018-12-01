import Foundation

public struct Directory {
  public let path: String

  public init(path: String) {
    self.path = path
  }

  public init(relativePath: String) {
    let currentDirPath = FileManager.default.currentDirectoryPath
    let path = currentDirPath + relativePath
    self.init(path: path)
  }

  func urlPath(for file: File) -> URL {
    return URL(fileURLWithPath: path(for: file))
  }

  func path(for file: File) -> String {
    return path + "/" + file.fullname
  }
}
