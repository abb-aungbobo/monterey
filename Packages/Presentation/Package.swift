// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Presentation",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Presentation",
            targets: ["Presentation"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/SnapKit/SnapKit.git", .upToNextMajor(from: "5.7.1")),
        .package(url: "https://github.com/rechsteiner/Parchment.git", .upToNextMajor(from: "3.4.0")),
        .package(path: "../Core"),
        .package(path: "../Domain"),
        .package(path: "../Extensions")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Presentation",
            dependencies: [
                .product(name: "SnapKit", package: "SnapKit"),
                .product(name: "Parchment", package: "Parchment"),
                .product(name: "Core", package: "Core"),
                .product(name: "Domain", package: "Domain"),
                .product(name: "Extensions", package: "Extensions")
            ]
        ),
        .testTarget(
            name: "UIComponents",
            dependencies: ["Presentation"]
        )
    ]
)
