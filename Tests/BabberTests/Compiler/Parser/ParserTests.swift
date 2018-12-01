import XCTest
import Nimble
@testable import BabberKit

final class ParserTests: XCTestCase {
  func parse(_ src: String, fileName: String = "Object") -> Node? {
    let tokens = Lexer().tokenize(src)
    return parse(tokens, fileName: fileName)
  }

  func parse(_ tokens: [Token], fileName: String = "Object") -> Node? {
    return Parser().parse(fileName: fileName, tokens: tokens)
  }

  func testFileDeclaration() {
    expect(self.parse([], fileName: "Iterator"))
      .to(equal(FileDeclaration(name: "Iterator")))
  }

  func testNumberLiteral() {
    expect(self.parse([.number("3")]))
      .to(equal(FileDeclaration(name: "Object", [NumberLiteral("3")])))
  }

  func testStringLiteral() {
    let actual = parse([
      .quote, .label("hello"), .space(1), .label("world"), .quote
    ])
    let expected = FileDeclaration(name: "Object", [StringLiteral("hello world")])
    expect(actual).to(equal(expected))
  }

  func testUnaryMessageDeclaration() {
    let actual = parse("msg get_age => 5")
    let expected = FileDeclaration(name: "Object", [
      UnaryMessageDeclaration(selector: "get_age", [
        NumberLiteral("5")
      ])
    ])
    expect(actual).to(equal(expected))
  }

  func testMultipleUnaryMessageDeclarations() {
    let actual = parse("""
    msg get_age =>
      11

    msg get_name =>
      "Jean"
    """)

    let expected = FileDeclaration(name: "Object", [
      UnaryMessageDeclaration(selector: "get_age", [
        NumberLiteral("11")
      ]),
      UnaryMessageDeclaration(selector: "get_name", [
        StringLiteral("Jean")
      ])
    ])

    expect(actual).to(equal(expected))
  }

  func testBinaryMessageDeclaration() {}
  func testKeywordMessageDeclaration() {}

  func testEmptyClassDeclaration() {
    let actual = self.parse("class Iterator =>")
    let expected = FileDeclaration(name: "Object", [ClassDeclaration(name: "Iterator")])
    expect(actual).to(equal(expected))
  }

  func testClassDeclarationWithMessages() {
    let actual = parse("""
    class Dog =>
      msg bark =>
        "woof"

      msg get_name =>
        "Tigo"
    """)

    let expected = FileDeclaration(name: "Object", [
      ClassDeclaration(name: "Dog", [
        UnaryMessageDeclaration(selector: "bark", [
          StringLiteral("woof")
        ]),
        UnaryMessageDeclaration(selector: "get_name", [
          StringLiteral("Tigo")
        ])
      ])
    ])

    expect(actual).to(equal(expected))
  }

  func testSubsequentClassDeclarations() {
    let actual = parse("""
    class Dog =>
      msg get_name =>
        "Tigo"

    class Cat =>
      msg get_name =>
        "Chichi"
    """)

    let expected = FileDeclaration(name: "Object", [
      ClassDeclaration(name: "Dog", [
        UnaryMessageDeclaration(selector: "get_name", [
          StringLiteral("Tigo")
        ])
      ]),
      ClassDeclaration(name: "Cat", [
        UnaryMessageDeclaration(selector: "get_name", [
          StringLiteral("Chichi")
        ])
      ])
    ])

    expect(actual).to(equal(expected))
  }

  func testFileStartingWithSpaces() {
    let expected = FileDeclaration(name: "Object", [
      ClassDeclaration(name: "Dog")
    ])
    expect(self.parse("    class Dog =>")).to(equal(expected))
  }

  func testVariable() {
    let expected = FileDeclaration(name: "Object", [
      Variable("animal")
    ])
    expect(self.parse("animal")).to(equal(expected))
  }

  func testVariableInMessageDeclaration() {
    let actual = parse("""
    msg get_animal =>
      animal
    """)

    let expected = FileDeclaration(name: "Object", [
      UnaryMessageDeclaration(selector: "get_animal", [
        Variable("animal")
      ])
    ])

    expect(actual).to(equal(expected))
  }

  func testSendExpression() {
    let expected = FileDeclaration(name: "Object", [
      SendExpression(
        selector: "increment",
        receiver: Variable("number"),
        params: []
      )
    ])
    expect(self.parse("number increment")).to(equal(expected))
  }

  func testSendExpressionChaining() {
    let expected = FileDeclaration(name: "Object", [
      SendExpression(
        selector: "to_string",
        receiver: SendExpression(
          selector: "to_int",
          receiver: SendExpression(
            selector: "add_ten",
            receiver: Variable("number"),
            params: []
          ),
          params: []
        ),
        params: []
      )
    ])
    expect(self.parse("number add_ten to_int to_string")).to(equal(expected))
  }

  func testSelf() {
    expect(self.parse("self")).to(equal(FileDeclaration(name: "Object", [SelfReference()])))
  }

  func testClassWithExpressions() {
    let actual = self.parse("""
    class HumanRepo =>
      msg first =>
        self humans first to_string
    """)

    let expected = FileDeclaration(name: "Object", [
      ClassDeclaration(name: "HumanRepo", [
        UnaryMessageDeclaration(selector: "first", [
          SendExpression(
            selector: "to_string",
            receiver: SendExpression(
              selector: "first",
              receiver: SendExpression(
                selector: "humans",
                receiver: SelfReference(),
                params: []
              ),
              params: []
            ),
            params: []
          )
        ])
      ])
    ])

    expect(actual).to(equal(expected))
  }

  func testPrintStatement() {
    expect(self.parse("print name")).to(equal(FileDeclaration(name: "Object", [
      PrintStatement([
        Variable("name")
      ])
    ])))
  }

  func testNumberAssignmentStatement() {
    let expected = FileDeclaration(name: "Object", [
      AssignmentStatement(
        variableName: "number",
        value: NumberLiteral("5"))
    ])
    expect(self.parse("number = 5")).to(equal(expected))
  }

  func testStringAssignmentStatement() {
    let actual = parse("""
    dog_name = "Tigo"
    """)

    let expected = FileDeclaration(name: "Object", [
      AssignmentStatement(
        variableName: "dog_name",
        value: StringLiteral("Tigo")
      )
    ])

    expect(actual).to(equal(expected))
  }

  func testExpressionAssignment() {
    let expected = FileDeclaration(name: "Object", [
      AssignmentStatement(
        variableName: "result",
        value: SendExpression(
          selector: "compute_result",
          receiver: SelfReference(),
          params: []
        )
      )
    ])
    expect(self.parse("result = self compute_result")).to(equal(expected))
  }

  func testAssignmentInContext() {
    let actual = parse("""
    class Iterator =>
      msg next =>
        elem = self current
        self cursor increment
        elem
    """)

    let expected = FileDeclaration(name: "Object", [
      ClassDeclaration(name: "Iterator", [
        UnaryMessageDeclaration(selector: "next", [
          AssignmentStatement(variableName: "elem", value: SendExpression(
            selector: "current",
            receiver: SelfReference(),
            params: []
          )),
          SendExpression(
            selector: "increment",
            receiver: SendExpression(
              selector: "cursor",
              receiver: SelfReference(),
              params: []
            ),
            params: []
          ),
          Variable("elem")
        ])
      ])
    ])

    expect(actual).to(equal(expected))
  }
}
