// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Fuse",
    products: [
        .library(name: "Fuse", targets: ["Fuse"]),
    ],
    targets: [
        .target(name: "Fuse"),
        // .testTarget(name: "FuseTests", dependencies: ["Fuse"]),
    ],
    swiftLanguageVersions: [
        .v5
    ]
)
