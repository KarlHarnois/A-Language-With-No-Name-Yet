// swift-tools-version:4.2

import PackageDescription

let package = Package(
  name: "compiler",
  dependencies: [
    .package(url: "https://github.com/Quick/Nimble.git", from: "7.3.1")
  ],
  targets: [
    .target(name: "Compiler", dependencies: []),
    .testTarget(name: "CompilerTests", dependencies: ["Compiler", "Nimble"])
  ]
 )
