final class SendExpression: Expression {
  let selector: String
  let receiver: Node
  let params: [Node]

  init(selector: String, receiver: Node, params: [Node]) {
    self.selector = selector
    self.receiver = receiver
    self.params = params
    super.init()
    attributes["selector"] = selector
    attributes["receiver"] = receiver.serialized
    attributes["params"] = params.map { $0.serialized }
  }
}
