// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "Scmark",
    platforms: [
        .macOS(.v10_14),
        .iOS(.v11),
        .watchOS(.v3),
        .tvOS(.v12),
    ],
    products: [
        .library(name: "Scmark", targets: ["Scmark"]),
    ],
    targets: [
        .target(
            name: "Ccmark",
            exclude: ["COPYING"],
            resources: [
                .process("src/scanners.re"),
                .process("src/make_entities_inc.py"),
                .process("src/entities.inc"),
                .process("src/case_fold_switch.inc"),
            ]
          ),
        .target(name: "Scmark", dependencies: ["Ccmark"]),
        .testTarget( name: "ScmarkTests", dependencies: ["Scmark"]),
    ]
)
