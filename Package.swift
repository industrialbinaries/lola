// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "lola",
  platforms: [
    .macOS(.v10_12),
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
      dependencies: ["LolaCore", "CupertinoJWT"]
    ),
    .target(
      name: "LolaCore",
      dependencies: ["CupertinoJWT"]
    ),
    .testTarget(
      name: "LolaTests",
      dependencies: ["lola"]
    ),
  ]
)
