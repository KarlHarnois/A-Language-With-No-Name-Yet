import Foundation

struct JsonSerialization {
  private let options: JSONSerialization.WritingOptions

  init(_ options: JSONSerialization.WritingOptions = []) {
    self.options = options
  }

  func string(_ node: Node) -> String {
    return jsonData(node.serialized).flatMap(jsonString) ?? ""
  }

  private func jsonString(_ json: Data) -> String? {
    return String(data: json, encoding: .utf8)
  }

  private func jsonData(_ object: Any) -> Data? {
    return try? JSONSerialization.data(withJSONObject: object, options: options)
  }
}
