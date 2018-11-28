import Foundation

enum Error: LocalizedError {
  case invalidCommand(String),
       unknownOption(String),
       missingRequiredOption(Flag),
       missingValue(Flag),
       invalidOption(Flag, String),
       custom(String)

  public var errorDescription: String? {
    return "error: ".style(.red, .bold) + message
  }

  private var message: String {
    switch self {
    case .invalidCommand(let command):
      return "invalid command \(command)"

    case .unknownOption(let option):
      return "unknown option \(option)"

    case .missingRequiredOption(let flag):
      return "required option \(flag.verbose) is missing"

    case .missingValue(let flag):
      return "option \(flag.verbose) requires a value; provide a value using '\(flag.verbose) <value>' or '\(flag.shorthand) <value>'"

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
