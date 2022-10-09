// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "JSQSystemSoundPlayer",
    platforms: [.iOS(.v9), .macOS(.v10_10), .tvOS(.v9)],
    products: [
        .library(
            name: "JSQSystemSoundPlayer",
            targets: ["JSQSystemSoundPlayer"]
        )
    ],
    targets: [
        .target(
            name: "JSQSystemSoundPlayer",
            path: "Source",
            exclude: ["Info.plist"],
            publicHeadersPath: "."
        ),
        .testTarget(
            name: "JSQSystemSoundPlayerTests",
            dependencies: ["JSQSystemSoundPlayer"],
            path: "Tests",
            exclude: ["Info.plist"],
            resources: [.process("SampleSounds")]
        )
    ]
)
