// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "request-model",
    platforms: [
        .macOS(.v13),
        .iOS(.v15),
    ],
    products: [
        .library(name: "RequestModel", targets: ["RequestModel"]),
    ],
    dependencies: [],
    targets: [
        .target(name: "RequestModel", dependencies: []),
    ]
)

/// Swift compiler settings for Release configuration.
var swiftSettings: [SwiftSetting] { [
	// Enable maximum optimizations in release
	.unsafeFlags(["-O"], .when(configuration: .release)),
	// "ExistentialAny" is an option that makes the use of the `any` keyword for existential types `required`
	.enableUpcomingFeature("ExistentialAny")
] }

/// Linker settings for stripping symbols.
var linkerSettings: [LinkerSetting] { [
	// Linker settings to strip all symbols (incl. debug info)
	.unsafeFlags(["-Xlinker", "-s"], .when(configuration: .release))
] }
