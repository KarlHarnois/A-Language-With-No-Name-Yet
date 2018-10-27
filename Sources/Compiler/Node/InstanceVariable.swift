final class InstanceVariable: Node {
  let name: String

  init(_ name: String) {
    self.name = name
    super.init()
    attributes["name"] = name
  }
}
