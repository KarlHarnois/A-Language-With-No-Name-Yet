import XCTest
import Nimble
@testable import Compiler

final class ParserTests: XCTestCase {
  func parse(_ src: String) -> Node? {
    let tokens = Lexer().tokenize(src)
    return parse(tokens)
  }

  func parse(_ tokens: [Token]) -> Node? {
    return Parser().parse(tokens)
  }

  func testProgramDeclaration() {
    expect(self.parse([]))
      .to(equal(ProgramDeclaration()))
  }

  func testNumberLiteral() {
    expect(self.parse([.number("3")]))
      .to(equal(ProgramDeclaration([NumberLiteral("3")])))
  }

  func testStringLiteral() {
    let actual = parse([
      .quote, .label("hello"), .space(1), .label("world"), .quote
    ])
    let expected = ProgramDeclaration([StringLiteral("hello world")])
    expect(actual).to(equal(expected))
  }

  func testUnaryMessageDeclaration() {
    let actual = parse("msg get_age => 5")
    let expected = ProgramDeclaration([
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

    let expected = ProgramDeclaration([
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
    let expected = ProgramDeclaration([ClassDeclaration(name: "Iterator")])
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

    let expected = ProgramDeclaration([
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

    let expected = ProgramDeclaration([
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

  func testProgramStartingWithSpaces() {
    let expected = ProgramDeclaration([
      ClassDeclaration(name: "Dog")
    ])
    expect(self.parse("    class Dog =>")).to(equal(expected))
  }

  func testVariable() {
    let expected = ProgramDeclaration([
      Variable("animal")
    ])
    expect(self.parse("animal")).to(equal(expected))
  }

  func testVariableInMessageDeclaration() {
    let actual = parse("""
    msg get_animal =>
      animal
    """)

    let expected = ProgramDeclaration([
      UnaryMessageDeclaration(selector: "get_animal", [
        Variable("animal")
      ])
    ])

    expect(actual).to(equal(expected))
  }

  func testSendExpression() {
    let expected = ProgramDeclaration([
      SendExpression(
        selector: "increment",
        receiver: Variable("number"),
        params: []
      )
    ])
    expect(self.parse("number increment")).to(equal(expected))
  }

  func testSendExpressionChaining() {
    let expected = ProgramDeclaration([
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
    expect(self.parse("self")).to(equal(ProgramDeclaration([SelfReference()])))
  }

  func testClassWithExpressions() {
    let actual = self.parse("""
    class HumanRepo =>
      msg first =>
        self humans first to_string
    """)

    let expected = ProgramDeclaration([
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
    expect(self.parse("print name")).to(equal(ProgramDeclaration([
      PrintStatement([
        Variable("name")
      ])
    ])))
  }

  func testNumberAssignmentStatement() {
    let expected = ProgramDeclaration([
      AssignmentStatement(
        variableName: "number",
        value: NumberLiteral("5"))
    ])
    expect(self.parse("number = 5")).to(equal(expected))
  }
}
