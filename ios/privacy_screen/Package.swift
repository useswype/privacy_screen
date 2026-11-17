// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "privacy_screen",
    platforms: [
        .iOS("12.0"),
    ],
    products: [
        .library(name: "privacy-screen", targets: ["privacy_screen"]),
    ],
    dependencies: [
        .package(name: "FlutterFramework", path: "../FlutterFramework"),
    ],
    targets: [
        .target(
            name: "privacy_screen",
            dependencies: [
                .product(name: "FlutterFramework", package: "FlutterFramework"),
            ]
        ),
    ]
)
