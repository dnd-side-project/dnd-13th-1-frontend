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
    targets: [
            .target(
                name: "AlloPresentation",
                resources: [
                    .process("Resources")
                ]
            )
        ]
)
