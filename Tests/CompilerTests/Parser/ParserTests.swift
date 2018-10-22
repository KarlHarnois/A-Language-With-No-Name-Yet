import XCTest
import Nimble
@testable import Compiler

class ParserTests: XCTestCase {
  func parse(_ src: String) -> Node? {
    let tokens = Lexer().tokenize(src)
    return parse(tokens)
  }

  func parse(_ tokens: [Token]) -> Node? {
    return Parser().parse(tokens)
  }

  func testProgramDeclaration() {
    expect(self.parse([])) == ProgramDeclaration()
  }

  func testNumberLiteral() {
    expect(self.parse([.number("3")])) == ProgramDeclaration([
      NumberLiteral("3")
    ])
  }

  func testStringLiteral() {
    let tokens: [Token] = [
      .quote, .label("hello"), .space(1), .label("world"), .quote
    ]
    expect(self.parse(tokens)) == ProgramDeclaration([
      StringLiteral("hello world")
    ])
  }

  func testUnaryMessageDeclaration() {
    let actual = parse("msg get_age => 5")
    let expected = ProgramDeclaration([
      UnaryMessageDeclaration(selector: "get_age", [
        NumberLiteral("5")
      ])
    ])
    expect(actual) == expected
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

    expect(actual) == expected
  }

  func testBinaryMessageDeclaration() {}
  func testKeywordMessageDeclaration() {}

  func testEmptyClassDeclaration() {
    let actual = self.parse("class Iterator =>")
    let expected = ProgramDeclaration([ClassDeclaration(name: "Iterator")])
    expect(actual) == expected
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

    expect(actual) == expected
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

    expect(actual) == expected
  }
}
