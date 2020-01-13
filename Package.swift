// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "LolaCore",
  platforms: [
    .macOS(.v10_12),
    .iOS(.v10),
  ],
  products: [
    .library(
      name: "LolaCore",
      targets: ["LolaCore"]
    ),
  ],
  dependencies: [
    .package(
      url: "https://github.com/industrialbinaries/CupertinoJWT",
      from: "0.2.2"
    ),
  ],
  targets: [
    .target(
      name: "lola",
      dependencies: ["LolaCore"]
    ),
    .target(
      name: "LolaCore",
      dependencies: ["CupertinoJWT"]
    ),
    .testTarget(
      name: "LolaTests",
      dependencies: ["LolaCore"]
    ),
  ]
)
