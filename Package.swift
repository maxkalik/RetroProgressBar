// swift-tools-version: 5.4
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RetroProgressBar",
    platforms: [.iOS(.v12)],
    products: [
        .library(
            name: "RetroProgressBar",
            targets: ["RetroProgressBar"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "RetroProgressBar"),
        .testTarget(
            name: "RetroProgressBarTests",
            dependencies: ["RetroProgressBar"]),
    ],
    swiftLanguageVersions: [.v5]
)
