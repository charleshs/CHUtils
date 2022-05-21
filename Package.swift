// swift-tools-version: 5.6
import PackageDescription

let package = Package(
    name: "CHUtils",
    platforms: [
        .iOS(.v8),
        .tvOS(.v9),
        .watchOS(.v2),
        .macOS(.v10_10),
        .macCatalyst(.v13),
    ],
    products: [
        .library(
            name: "CHUtils",
            targets: ["CHUtils"]
        ),
    ],
    targets: [
        .target(
            name: "CHUtils",
            dependencies: []
        ),
        .testTarget(
            name: "CHUtilsTests",
            dependencies: ["CHUtils"]
        ),
    ]
)
