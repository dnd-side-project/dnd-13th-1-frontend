// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AlloPresentation",
    platforms: [.iOS(.v18)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "AlloPresentation",
            targets: ["AlloPresentation"]),
    ],
    dependencies: [
        .package(path: "../AlloDomain")
    ],
    targets: [
        .target(
            name: "AlloPresentation",
            dependencies: ["AlloDomain"],
            resources: [
                .process("Resources")
            ]
        )
    ]
)
