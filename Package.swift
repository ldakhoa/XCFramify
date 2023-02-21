// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "nab-create-xcframework",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "nab-create-xcframework",
            targets: ["nab-create-xcframework"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "nab-create-xcframework",
            dependencies: []),
        .testTarget(
            name: "nab-create-xcframeworkTests",
            dependencies: ["nab-create-xcframework"]),
    ]
)
