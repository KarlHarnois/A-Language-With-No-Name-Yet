import Foundation

extension String {
  subscript(i: Int) -> String {
    return String(self[index(startIndex, offsetBy: i)])
  }

  func match(_ regex: String) -> Bool {
    return range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
  }

  func style(_ color: Color = .default, _ weight: Weight = .regular) -> String {
    return "\u{001B}[\(weight.rawValue);\(color.rawValue)m" + self + "\u{001B}[\(Weight.regular.rawValue);\(Color.default.rawValue)m"
  }

  enum Weight: Int {
    case regular = 0
    case bold = 1
  }

  enum Color: Int {
    case red = 31
    case `default` = 0
  }
}
