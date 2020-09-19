// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "Scmark",
    products: [
        .library(
            name: "Scmark",
            targets: ["Scmark"]
        ),
    ],
    targets: [
        .target(name: "Scmark", dependencies: ["Ccmark"]),
        .target(name: "Ccmark"),
        .target(
            name: "WindowsTests",
            dependencies: ["Scmark"],
            path: "./Tests/"
        ),
    ]
)
