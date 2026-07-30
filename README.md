# swift-mailgun-types

![Development Status](https://img.shields.io/badge/status-active--development-blue.svg)
[![CI](https://github.com/swift-standards/swift-mailgun-types/workflows/CI/badge.svg)](https://github.com/swift-standards/swift-mailgun-types/actions/workflows/ci.yml)

Foundation-free Swift value types for Mailgun's REST API contracts.

## Ecosystem

This package belongs to the Swift Institute Standards layer. It preserves Mailgun's
published wire vocabulary — messages, templates, lists, domains, suppressions,
reporting, infrastructure, and account-management request/response/payload types —
while leaving transport, authentication, retries, and application persistence to
higher layers:

- **swift-mailgun-types** (this package) — request, response, and payload value types
- **swift-mailgun-live** — the HTTP binding (URLSession, authentication, live routing)
- **swift-mailgun** — the developer-facing entry point, re-exporting `swift-mailgun-live`
  with additional integrations (HTML email composition, identity systems)

## Products

| Product | Module | Purpose |
| --- | --- | --- |
| Mailgun Standard | `Mailgun_Standard` | Mailgun request, response, identifier, and payload contracts across every resource domain |

## Installation

Add the package and depend on the `Mailgun Standard` product:

```swift
dependencies: [
    .package(
        url: "https://github.com/swift-standards/swift-mailgun-types.git",
        branch: "main"
    )
]
```

```swift
.target(
    name: "YourTarget",
    dependencies: [
        .product(
            name: "Mailgun Standard",
            package: "swift-mailgun-types"
        )
    ]
)
```

## Usage

```swift
import Mailgun_Standard

let request = Mailgun.Messages.Send.Request(
    from: try .init("hello@yourdomain.com"),
    to: [try .init("user@example.com")],
    subject: "Welcome to swift-mailgun-types!",
    html: "<h1>Type-safe emails</h1><p>Built with Swift</p>"
)
```

### Templates

```swift
let template = Mailgun.Templates.Create.Request(
    name: "welcome-email",
    description: "Welcome email for new users",
    template: "<h1>Welcome {{name}}!</h1>",
    tag: "v1.0"
)
```

### Suppressions

```swift
let bounce = Mailgun.Suppressions.Bounces.Create.Request(
    address: try .init("invalid@example.com"),
    code: "550",
    error: "Mailbox does not exist"
)

let allowlist = Mailgun.Suppressions.Allowlist.Create.Request.address(
    try .init("vip@partner.com")
)
```

### Reporting

```swift
let statsQuery = Mailgun.Reporting.Stats.Total.Request(
    event: "delivered",
    start: "2024-01-01",
    end: "2024-01-31",
    resolution: "day",
    duration: "1M"
)
```

### Domains

```swift
let createRequest = Mailgun.Domains.Domains.Create.Request(
    name: "mail.yourdomain.com"
)

let listRequest = Mailgun.Domains.Domains.List.Request(
    authority: "example.com",
    state: .active,
    limit: 10,
    skip: 0
)
```

## Wire-type mapping

Foundation is not imported. Fields whose wire form is a Foundation type map onto
Institute Standards/Primitives types instead:

| Wire form | Mailgun field examples | Swift type |
| --- | --- | --- |
| Unix-epoch seconds | `Messages.Send.Request.deliveryTime`, `Routes.Route.createdAt`, `Reporting.Events.List.begin` | `Time.Epoch` (`Time Primitive`, swift-time-primitives) |
| Binary payload | `Messages.Attachment.Data.data`, `Suppressions.Bounces.Import.Request.file` | `[UInt8]` |
| Pagination link | `Lists.Paging.first`, `Reporting.Tags.*.Paging.first` | `RFC_3986.URI` (`RFC 3986`, swift-rfc-3986) |
| Email address | every `address`/`from`/`to`/`cc`/`bcc` field | `EmailAddress` (`EmailAddress Standard`, swift-emailaddress-standard) |

## Architecture

`Mailgun_Standard` defines contracts only. The per-resource `*.API.swift` URLRouting
routers and `*.Client.swift` witnesses that previously lived in this package are
being rebuilt at their correct layers: HTTP request construction in
[swift-mailgun-live](https://github.com/swift-foundations/swift-mailgun-live)'s
`Mailgun HTTP` rebuild, and typed clients in
[swift-mailgun](https://github.com/swift-foundations/swift-mailgun)'s domain
rebuild. No deprecated per-resource `Mailgun <Resource> Types` products or the
`Mailgun Types` umbrella product are provided.

## License

This project is licensed under the Apache License 2.0. See [LICENSE](LICENSE) for
details.
