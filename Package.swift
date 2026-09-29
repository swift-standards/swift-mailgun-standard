// swift-tools-version: 6.4

import PackageDescription

let package = Package(
    name: "swift-mailgun-standard",
    platforms: [
        .macOS(.v27),
        .iOS(.v27),
        .tvOS(.v27),
        .watchOS(.v27),
        .visionOS(.v27),
    ],
    products: [
        .library(
            name: "Mailgun Standard",
            targets: ["Mailgun Standard"]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/swift-atoms/swift-byte.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-standards/swift-domain-standard.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-standards/swift-email-standard.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-standards/swift-emailaddress-standard.git",
            branch: "main"
        ),
        .package(url: "https://github.com/swift-ietf/swift-rfc-2045.git", branch: "main"),
        .package(url: "https://github.com/swift-ietf/swift-rfc-2046.git", branch: "main"),
        .package(url: "https://github.com/swift-ietf/swift-rfc-3986.git", branch: "main"),
        .package(url: "https://github.com/swift-ietf/swift-rfc-5322.git", branch: "main"),
        .package(
            url: "https://github.com/swift-atoms/swift-time.git",
            branch: "main"
        ),
    ],
    targets: [
        .target(
            name: "Mailgun Standard",
            dependencies: [
                .product(name: "Byte", package: "swift-byte"),
                .product(
                    name: "Byte",
                    package: "swift-byte"
                ),

                .product(name: "Domain Standard", package: "swift-domain-standard"),
                .product(
                    name: "Domain Foundation Integration",
                    package: "swift-domain-standard"
                ),
                .product(name: "Email Standard", package: "swift-email-standard"),
                .product(name: "EmailAddress Standard", package: "swift-emailaddress-standard"),
                .product(
                    name: "EmailAddress Foundation Integration",
                    package: "swift-emailaddress-standard"
                ),

                .product(name: "RFC 2045", package: "swift-rfc-2045"),
                .product(name: "RFC 2046", package: "swift-rfc-2046"),
                .product(name: "RFC 3986", package: "swift-rfc-3986"),
                .product(
                    name: "RFC 3986 Foundation Integration",
                    package: "swift-rfc-3986"
                ),
                .product(name: "RFC 5322", package: "swift-rfc-5322"),

                .product(name: "Time", package: "swift-time"),
            ]
        ),
        .testTarget(
            name: "Mailgun Standard Tests",
            dependencies: [
                "Mailgun Standard",

                .product(name: "Byte", package: "swift-byte"),
                .product(
                    name: "Byte",
                    package: "swift-byte"
                ),
                .product(name: "Email Standard", package: "swift-email-standard"),
                .product(name: "EmailAddress Standard", package: "swift-emailaddress-standard"),
                .product(name: "RFC 2046", package: "swift-rfc-2046"),
                .product(name: "RFC 5322", package: "swift-rfc-5322"),
                .product(name: "Time", package: "swift-time"),
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    let ecosystem: [SwiftSetting] = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("Lifetimes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
    ]

    let package: [SwiftSetting] = []

    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem + package
}
