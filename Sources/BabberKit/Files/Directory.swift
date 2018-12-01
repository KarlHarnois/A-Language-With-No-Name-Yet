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
}
