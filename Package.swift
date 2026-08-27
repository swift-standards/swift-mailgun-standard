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
        .package(url: "https://github.com/swift-ietf/swift-rfc-2046.git", branch: "main"),
        .package(url: "https://github.com/swift-ietf/swift-rfc-3986.git", branch: "main"),

        .package(
            url: "https://github.com/swift-molecules/swift-time.git",
            branch: "main"
        ),
    ],
    targets: [
        .target(
            name: "Mailgun Standard",
            dependencies: [
                .product(name: "Domain Standard", package: "swift-domain-standard"),
                .product(name: "Email Standard", package: "swift-email-standard"),
                .product(name: "EmailAddress Standard", package: "swift-emailaddress-standard"),

                .product(name: "RFC 3986", package: "swift-rfc-3986"),

                .product(name: "Time Primitive", package: "swift-time"),
            ]
        ),
        .testTarget(
            name: "Mailgun Standard Tests",
            dependencies: [
                "Mailgun Standard",

                .product(name: "RFC 2046", package: "swift-rfc-2046"),
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)
