// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FoodsFinderPackage",
    platforms: [.iOS(.v16)],
    products: [
        .library(name: "Core", targets: ["Core"]),
        .library(name: "API", targets: ["API"]),
        .library(name: "Entity", targets: ["Entity"]),
        .library(name: "View", targets: ["View"]),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture.git", exact: "1.16.1"),
        .package(url: "https://github.com/rentarouapp/CocoaNetworkingMonitor.git", branch: "main"),
    ],
    targets: [
        .target(name: "Core",
                dependencies: [
                    "Entity",
                    "API",
                    .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
                    .product(name: "CocoaNetworkingMonitor", package: "CocoaNetworkingMonitor"),
                ]
               ),
        .target(name: "API",
                dependencies: [
                    "Entity",
                ]
               ),
        .target(name: "Entity",
                dependencies: []
               ),
        .target(name: "View",
                dependencies: [
                    "Core",
                ]
               ),
    ]
)
