// swift-tools-version: 6.3.3

import PackageDescription

let package = Package(
    name: "swift-mailgun-standard",
    platforms: [
        .macOS(.v26),
        .iOS(.v26),
        .tvOS(.v26),
        .watchOS(.v26),
        .visionOS(.v26),
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
        .package(url: "https://github.com/swift-standards/swift-email-standard.git", branch: "main"),
        .package(
            url: "https://github.com/swift-standards/swift-emailaddress-standard.git",
            branch: "main"
        ),
        .package(url: "https://github.com/swift-ietf/swift-rfc-2046.git", branch: "main"),
        .package(url: "https://github.com/swift-ietf/swift-rfc-3986.git", branch: "main"),
        // swift-primitives/swift-time-primitives has zero tags and zero releases. The Institute
        // develops solely on main and issues no tag authorization (coordinator ruling, #13);
        // this dependency is tracked with branch: "main" per ecosystem convention, not as a
        // pending exemption awaiting a future tag.
        .package(
            url: "https://github.com/swift-primitives/swift-time-primitives.git",
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
                // Pagination links (Lists.Paging, Reporting.Tags.*.Paging, ...).
                .product(name: "RFC 3986", package: "swift-rfc-3986"),
                // Unix-epoch-seconds timestamp fields.
                .product(name: "Time Primitive", package: "swift-time-primitives"),
            ]
        ),
        .testTarget(
            name: "Mailgun Standard Tests",
            dependencies: [
                "Mailgun Standard",
                // Multipart test fixture for Email -> Mailgun.Messages.Send.Request conversion.
                .product(name: "RFC 2046", package: "swift-rfc-2046"),
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)
