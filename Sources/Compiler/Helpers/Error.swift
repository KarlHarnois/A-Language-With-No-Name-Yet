import Foundation

enum Error: LocalizedError {
  case invalidCommand(_ command: String)
  case missingTarget, invalidTarget(_ target: String)
  case custom(_ message: String)

  public var errorDescription: String? {
    return "error: " + message
  }

  private var message: String {
    switch self {
    case .invalidCommand(let command):
      return "invalid command \(command)"

    case .missingTarget:
      return "missing build target, use --target <argument>"

    case .invalidTarget(let target):
      return "invalid target \(target)"

    case .custom(let msg):
      return msg
    }
  }
}

extension Error: Equatable {
  public static func == (a: Error, b: Error) -> Bool {
    return a.localizedDescription == b.localizedDescription
  }
}
