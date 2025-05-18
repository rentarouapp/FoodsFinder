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
        .package(url: "https://github.com/rentarouapp/CocoaNetworkingMonitor.git", .upToNextMajor(from: "0.1.0")),
        .package(url: "https://github.com/pkluz/PKHUD.git", .upToNextMinor(from: "5.4.0")),
    ],
    targets: [
        .target(name: "Core",
                dependencies: [
                    "Entity",
                    "API",
                    "CocoaNetworkingMonitor",
                    .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
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
                    "PKHUD",
                ]
               ),
    ]
)
