// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "nab-create-xcframework",
    platforms: [
        .macOS(.v13)
    ],
    products: [
        .executable(name: "nab-create-xcframework", targets: ["nab-create-xcframework"]),
        .library(
            name: "NABCreateXCFrameworkKit",
            targets: ["NABCreateXCFrameworkKit"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-package-manager.git",
                 revision: "4582d479ff0684e81d64897949c4d8d69187ec35"),
        .package(url: "https://github.com/apple/swift-log.git",
                 .upToNextMinor(from: "1.4.2")),
        .package(url: "https://github.com/apple/swift-argument-parser.git",
                 from: "1.1.0"),
        .package(url: "https://github.com/onevcat/Rainbow",
                 .upToNextMinor(from: "4.0.1")),
    ],
    targets: [
        .executableTarget(
            name: "nab-create-xcframework",
            dependencies: [
                .target(name: "NABCreateXCFrameworkKit"),
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
            ]),
        .target(
            name: "NABCreateXCFrameworkKit",
            dependencies: [
                .product(name: "XCBuildSupport", package: "swift-package-manager"),
                .product(name: "Logging", package: "swift-log"),
                .product(name: "Rainbow", package: "Rainbow"),
            ]),
        .testTarget(
            name: "NABCreateXCFrameworkKitTests",
            dependencies: ["NABCreateXCFrameworkKit"]),
    ]
)
