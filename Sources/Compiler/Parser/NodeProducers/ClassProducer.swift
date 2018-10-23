final class ClassProducer: NodeProducer {
  override func produce() -> Node? {
    guard let name = produceClassName() else {
      return nil
    }
    let classNode = ClassDeclaration(name: name)

    while !isDoneIterating {
      guard current != .label("class") else { break }
      guard let node = walk() else { continue }
      classNode.add(node)
    }
    return classNode
  }

  private func produceClassName() -> String? {
    while let token = next() {
      guard case .label(let name) = token else { continue }
      advance(to: .operator("=>"))
      return name
    }
    return nil
  }
}
