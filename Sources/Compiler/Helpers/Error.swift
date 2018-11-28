import Foundation

enum Error: LocalizedError {
  case invalidCommand(String)
  case unknownOption(String), missingRequiredOption(Flag)
  case invalidOption(Flag, String)
  case custom(String)

  public var errorDescription: String? {
    return "error: " + message
  }

  private var message: String {
    switch self {
    case .invalidCommand(let command):
      return "invalid command \(command)"

    case .unknownOption(let option):
      return "unknown option \(option)"

    case .missingRequiredOption(let flag):
      return "required option \(flag.rawValue) is missing"

    case let .invalidOption(flag, value):
      return "no \(flag.rawValue) named \(value)"

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
