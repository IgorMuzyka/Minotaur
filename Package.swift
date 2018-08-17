// swift-tools-version:4.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "minotaur",
    products: [
        .executable(name: "minotaur", targets: ["minotaur"])
    ],
    dependencies: [
        .package(url: "https://github.com/IgorMuzyka/Cncurses", .branch("master")),
        .package(url: "https://github.com/kareman/SwiftShell", from: "4.0.0"),
        .package(url: "https://github.com/nvzqz/FileKit", from: "5.1.0"),

        .package(url: "https://github.com/Quick/Quick", from: "1.3.0"),
        .package(url: "https://github.com/Quick/Nimble", from: "7.1.0")
    ],
    targets: [
        .target(
            name: "minotaur",
            dependencies: ["Cncurses", "SwiftShell", "FileKit"]),
        .testTarget(
            name: "minotaurTests",
            dependencies: ["minotaur", "Quick", "Nimble"]),
    ]
)
