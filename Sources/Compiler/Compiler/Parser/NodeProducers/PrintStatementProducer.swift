final class PrintStatementProducer: NodeProducer {
  override func produce(_ opt: Options = [:]) -> Node? {
    return produceVariable().map { variable in
      PrintStatement([variable])
    }
  }

  private func produceVariable() -> Variable? {
    var variable: Variable?
    while let token = next() {
      guard case .label(let name) = token else {
        continue
      }
      variable = Variable(name)
      break
    }
    return variable
  }
}
