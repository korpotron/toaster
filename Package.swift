// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "Toaster",
    platforms: [
        .iOS(.v18),
    ],
    products: [
        .library(
            name: "Toaster",
            targets: [
                "Toaster"
            ]
        ),
    ],
    targets: [
        .target(
            name: "Toaster"
        ),
    ]
)
