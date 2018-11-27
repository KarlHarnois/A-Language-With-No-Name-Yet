import Foundation

enum Error: LocalizedError {
  case invalidArguments(_ arguments: [String])
  case custom(_ message: String)

  public var errorDescription: String? {
    return "error: " + message
  }

  private var message: String {
    switch self {
    case .invalidArguments(let args):
      return "invalid arguments: \(args)"
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
