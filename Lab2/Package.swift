// swift-tools-version:5.3
import PackageDescription
let package = Package(
  name: "Example",
  platforms: [.macOS(.v10_15)],
  products: [
    .executable(name: "Example", targets: ["Example"])
  ],
  dependencies: [
    .package(name: "Tokamak", url: "https://github.com/TokamakUI/Tokamak", from: "0.5.1")
  ],
  targets: [
    .target(
      name: "Example",
      dependencies: [
        .product(name: "TokamakShim", package: "Tokamak")
      ]),
    .testTarget(
      name: "ExampleTests",
      dependencies: ["Example"]),
  ]
)
