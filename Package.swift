// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Lola",
    platforms: [
        .macOS(.v10_12),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: "https://github.com/ethanhuang13/CupertinoJWT", from: "0.2.1"), // Currently not support SPM
    ],
    targets: [
        .target(
            name: "Lola",
            dependencies: ["LolaCore"]
        ),
        .target(name: "LolaCore"),
        .testTarget(
            name: "LolaTests",
            dependencies: ["Lola"]
        ),
    ]
)
