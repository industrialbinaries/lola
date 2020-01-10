// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Lola",
    platforms: [
        .macOS(.v10_12),
    ],
    dependencies: [
        .package(
            url: "https://github.com/terwanerik/CupertinoJWT",
            from: "0.2.2"
        ),
    ],
    targets: [
        .target(
            name: "Lola",
            dependencies: ["LolaCore", "CupertinoJWT"]
        ),
        .target(
            name: "LolaCore",
            dependencies: ["CupertinoJWT"]
        ),
        .testTarget(
            name: "LolaTests",
            dependencies: ["Lola"]
        ),
    ]
)
