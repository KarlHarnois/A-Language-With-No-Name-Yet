class Node {
  weak var parent: Node?
  var children: [Node] = []

  var type: String {
    return String(describing: Swift.type(of: self))
  }

  var stringRepresentation: String {
    return serialized.description
 }

  var serialized: [String: Any] {
    var base: [String: Any] = [
      "type": type,
      "children": children.map {$0.serialized}
    ]
    attributes.forEach { base[$0] = $1 }
    return base
  }

  internal var attributes: [String: Any] = [:]

  func add(_ node: Node) {
    node.parent = self
    children.append(node)
  }
}

extension Node: Equatable {
  public static func == (x: Node, y: Node) -> Bool {
    return x.stringRepresentation == y.stringRepresentation
  }
}
