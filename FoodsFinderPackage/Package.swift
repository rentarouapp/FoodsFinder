// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FoodsFinderPackage",
    platforms: [.iOS(.v16)],
    products: [
        .library(name: "Foods", targets: ["Foods"])
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture.git", exact: "1.16.1")
    ],
    targets: [
        .target(name: "Foods",
                dependencies: [
                    .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
                ]
               )
    ]
)
