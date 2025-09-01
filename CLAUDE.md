# swift-mailgun-types Architecture Guide

## Package Purpose

swift-mailgun-types provides the foundational types, models, and client interfaces for building type-safe Mailgun integrations in Swift. This package defines the contract for Mailgun API interactions without providing implementations, following a clean separation of concerns that enables:

- Type-safe API modeling with compile-time validation
- Testable client interfaces using closure-based architecture with `@DependencyClient` macro
- Modular feature organization for maintainability
- Platform-agnostic types that work across all Swift platforms (macOS 14+, iOS 17+)
- Full Swift 5.10+ compatibility with progressive Swift 6 adoption

## Architecture Patterns

### 1. Three-Package Architecture

This package is part of a modular three-package ecosystem:

```
swift-mailgun-types (this package)
├── Domain Models & Types
├── API Route Definitions (using swift-url-routing)
├── Client Interface Structs (@DependencyClient)
├── Form Encoding/Decoding Support

swift-mailgun-live (core implementation)
├── Live Client Implementations
├── URLSession Networking (via swift-urlrequest-handler)
├── Authentication Handling (via swift-authenticating)
└── Environment Configuration (via swift-environment-variables)

swift-mailgun (developer entry point)
├── Re-exports swift-mailgun-live
├── HTML email support (via swift-html)
├── Identity system integration
└── Additional convenience APIs
```

### 2. Closure-Based Client Architecture

Each feature client uses closures with the `@DependencyClient` macro from swift-dependencies:

```swift
extension Mailgun.Messages {
    @DependencyClient
    public struct Client: Sendable {
        @DependencyEndpoint
        public var send: @Sendable (_ request: Mailgun.Messages.Send.Request) async throws -> Mailgun.Messages.Send.Response
        
        @DependencyEndpoint
        public var sendMime: @Sendable (_ request: Mailgun.Messages.Send.Mime.Request) async throws -> Mailgun.Messages.Send.Response
        
        @DependencyEndpoint
        public var retrieve: @Sendable (_ storageKey: String) async throws -> Mailgun.Messages.StoredMessage
        
        @DependencyEndpoint
        public var queueStatus: @Sendable () async throws -> Mailgun.Messages.Queue.Status
        
        @DependencyEndpoint
        public var deleteAll: @Sendable () async throws -> Mailgun.Messages.Delete.Response
    }
}
```

This pattern enables:
- Multiple implementation strategies
- Clean dependency injection
- Type-safe API contracts
- Automatic test implementations

### 3. Modular Feature Organization

Each Mailgun API feature is organized in its own module with consistent naming:

```
Sources/
├── Mailgun Types/                    # Root aggregation and core types
├── Mailgun Messages Types/           # Email sending functionality
├── Mailgun Reporting Types/          # Analytics and reporting
│   ├── Events/                       # Event tracking
│   ├── Logs/                         # Log access
│   ├── Metrics/                      # Metrics API
│   ├── Stats/                        # Statistics
│   └── Tags/                         # Tag management
├── Mailgun Suppressions Types/       # Bounce/complaint management
│   ├── Bounces/                      # Bounce handling
│   ├── Complaints/                   # Complaint handling
│   ├── Unsubscribe/                  # Unsubscribe lists
│   └── Allowlist/                    # Allowlist management
├── Mailgun Domains Types/            # Domain management
│   ├── DKIM Security/                # DKIM configuration
│   ├── Domain Connection/            # Connection settings
│   ├── Domain Keys/                  # Domain API keys
│   └── Domain Tracking/              # Tracking settings
├── Mailgun Templates Types/          # Email templates
├── Mailgun Webhooks Types/           # Webhook configuration
├── Mailgun Lists Types/              # Mailing lists
├── Mailgun Routes Types/             # Email routing
├── Mailgun IPs Types/                # IP management
├── Mailgun IPPools Types/            # IP pool management
│   ├── IP Pools/                     # Static IP pools
│   └── Dynamic IP Pools/             # Dynamic IP pools with health checks
├── Mailgun IPAllowlist Types/        # IP allowlist
├── Mailgun Keys Types/               # API key management
├── Mailgun Users Types/              # User management
├── Mailgun Subaccounts Types/        # Subaccount management
├── Mailgun Credentials Types/        # Credential management
├── Mailgun CustomMessageLimit Types/ # Message limit configuration
├── Mailgun AccountManagement Types/  # Account management
└── Mailgun Types Shared/             # Shared utilities and types
```

### 4. Type-Safe API Routing

API routes are modeled as enums with associated values using swift-url-routing:

```swift
extension Mailgun.Messages {
    @CasePathable
    @dynamicMemberLookup
    public enum API: Equatable, Sendable {
        case send(domain: Domain, request: Mailgun.Messages.Send.Request)
        case sendMime(domain: Domain, request: Mailgun.Messages.Send.Mime.Request)
        case retrieve(domain: Domain, storageKey: String)
        case queueStatus(domain: Domain)
        case deleteScheduled(domain: Domain)
    }
}
```

Each API enum has a corresponding Router using URLRouting:

```swift
extension Mailgun.Messages.API {
    public struct Router: ParserPrinter, Sendable {
        public init() {}
        
        public var body: some URLRouting.Router<Mailgun.Messages.API> {
            OneOf {
                URLRouting.Route(.case(Mailgun.Messages.API.send)) {
                    Method.post
                    Path { "v3" }
                    Path { Parse(.string.representing(Domain.self)) }
                    Path.messages
                    Body(.form(Mailgun.Messages.Send.Request.self, decoder: .mailgun, encoder: .mailgun))
                }
                
                URLRouting.Route(.case(Mailgun.Messages.API.sendMime)) {
                    Method.post
                    Path { "v3" }
                    Path { Parse(.string.representing(Domain.self)) }
                    Path { "messages.mime" }
                    Body(.form(Mailgun.Messages.Send.Mime.Request.self, decoder: .mailgun, encoder: .mailgun))
                }
                // ... other routes
            }
        }
    }
}
```

### 5. Comprehensive Request/Response Modeling

All API requests and responses are fully modeled with Codable types:

```swift
extension Mailgun.Messages.Send {
    public struct Request: Sendable, Equatable, Codable {
        public let from: EmailAddress
        public let to: [EmailAddress]
        public let cc: [EmailAddress]?
        public let bcc: [EmailAddress]?
        public let subject: String
        public let html: String?
        public let text: String?
        public let ampHtml: String?
        public let attachment: [Attachment]?
        public let inline: [Attachment]?
        public let template: String?
        public let templateVariables: [String: String]?
        public let templateVersion: String?
        public let templateText: String?
        public let tag: [String]?
        public let dkim: Bool?
        public let deliveryTime: Date?
        public let testMode: Bool?
        public let tracking: Bool?
        public let trackingClicks: Tracking.Clicks?
        public let trackingOpens: Bool?
        public let requireTls: Bool?
        public let skipVerification: Bool?
        public let recipientVariables: [String: [String: String]]?
        public let headers: [String: String]?
        public let variables: [String: String]?
        
        // Comprehensive initializers with defaults
    }
    
    public struct Response: Sendable, Decodable, Equatable {
        public let id: String
        public let message: String
    }
}
```

## API Design Patterns

### @CasePathable for API Enums

All API enums should use `@CasePathable` for better ergonomics:

```swift
extension Mailgun.Messages {
    @CasePathable
    @dynamicMemberLookup
    public enum API: Equatable, Sendable {
        case send(domain: Domain, request: Mailgun.Messages.Send.Request)
        case retrieve(domain: Domain, storageKey: String)
        // ...
    }
}
```

This enables:
- `.is(\.caseName)` for case checking
- `.caseName?` for optional extraction
- Dynamic member lookup for nested properties

### Router Structure Pattern

Every API enum should have a corresponding Router:

```swift
extension Mailgun.Feature.API {
    public struct Router: ParserPrinter, Sendable {
        public init() {}
        
        public var body: some URLRouting.Router<Mailgun.Feature.API> {
            OneOf {
                // Routes ordered by specificity (PUT/DELETE before GET)
                // Routes with more specific paths before general ones
            }
        }
    }
}
```

## Common Patterns

### 1. Namespace Enums

Features use enum namespaces for clean organization:

```swift
public enum Mailgun {}           // Root namespace
public enum Messages {}          // Message-related types
public enum Suppressions {}      // Suppression features
public enum Templates {}         // Template management
public enum Reporting {}         // Reporting and analytics
public enum Domains {}           // Domain management
```

### 2. Nested Type Organization

Types are organized hierarchically to match API structure:

```
Mailgun
├── Messages
│   ├── Send
│   │   ├── Request
│   │   ├── Response
│   │   └── Mime
│   │       └── Request
│   ├── StoredMessage
│   ├── Queue
│   │   └── Status
│   └── Delete
│       └── Response
├── Suppressions
│   ├── Bounces
│   ├── Complaints
│   ├── Unsubscribe
│   └── Allowlist
└── Domains
    ├── DKIM
    ├── Connection
    ├── Keys
    └── Tracking
```

### 3. Test Support Pattern

The `@DependencyClient` macro automatically generates:
- Default unimplemented closures that fail tests if called
- Ability to override specific endpoints in tests
- Full test coverage support

### 4. Form Encoding/Decoding

Custom form decoders handle Mailgun's specific requirements via swift-url-form-coding:

```swift
extension Form.Decoder {
    public static var mailgun: Self {
        .init(
            arrayBracketsEnabled: true,
            boolEncoding: .literal,
            dataDecodingStrategy: .base64,
            dateDecodingStrategy: .custom { decoder in
                // Handle various Mailgun date formats
            }
        )
    }
}
```

The `.mailgun` decoder handles:
- Array encoding with `[]` suffix (e.g., `to[]`)
- Boolean conversion to "yes"/"no"
- Custom date formatting (RFC2822 and Unix timestamps)
- Base64 encoding for binary data
- Nested JSON encoding for complex parameters
- Multipart form data for attachments

### 5. Client Aggregation

The root Mailgun.Client aggregates the feature clients:

```swift
extension Mailgun {
    @DependencyClient
    public struct Client: Sendable {
        public let messages: Messages.Client
        public let mailingLists: Lists.Client
        public let events: Events.Client
        public let suppressions: Suppressions.Client
        public let webhooks: Webhooks.Client
        ...
        
        public init(
            messages: Messages.Client,
            mailingLists: Lists.Client,
            events: Events.Client,
            suppressions: Suppressions.Client,
            webhooks: Webhooks.Client,
            ...
        ) {
            self.messages = messages
            self.mailingLists = mailingLists
            self.events = events
            self.suppressions = suppressions
            self.webhooks = webhooks
            ...
        }
    }
}
```

Additional feature clients can be accessed independently for more specialized use cases.

## Usage Patterns

### Creating Custom Implementations

```swift
// Create a custom implementation
let messagesClient = Mailgun.Messages.Client(
    send: { request in
        // Your custom implementation
        // Could use URLSession, Alamofire, or any networking library
        return Mailgun.Messages.Send.Response(
            id: "custom-id",
            message: "Sent via custom implementation"
        )
    },
    sendMime: { request in
        // Custom MIME implementation
    },
    retrieve: { storageKey in
        // Custom retrieval logic
    }
)
```

### Testing with Mock Clients

```swift
import Testing
import Mailgun_Messages_Types

@Test
func testEmailSending() async throws {
    // Override specific endpoints for testing
    let client = Mailgun.Messages.Client(
        send: { request in
            #expect(request.subject == "Test Email")
            return .init(id: "test-123", message: "Queued. Thank you.")
        }
    )
    
    let request = Mailgun.Messages.Send.Request(
        from: .init("test@example.com"),
        to: [.init("recipient@example.com")],
        subject: "Test Email"
    )
    
    let response = try await client.send(request)
    #expect(response.id == "test-123")
}
```

### Integration with Dependency Injection

```swift
import Dependencies
import Mailgun_Types

struct MyFeature {
    @Dependency(Mailgun.Client.self) var mailgun
    
    func sendWelcomeEmail(to email: EmailAddress) async throws {
        let request = Mailgun.Messages.Send.Request(
            from: .init("noreply@company.com"),
            to: [.init(email)],
            subject: "Welcome!",
            template: "welcome",
            templateVariables: ["name": "New User"]
        )
        
        let response = try await mailgun.messages.send(request)
        print("Sent welcome email: \(response.id)")
    }
}
```

## Package.swift Patterns

The Package.swift uses consistent patterns for organization:

```swift
// String extensions for module names
extension String {
    static let mailgun: Self = "Mailgun".types
    static let messages: Self = "Mailgun Messages".types
    static let reporting: Self = "Mailgun Reporting".types
    // Consistent naming: "Mailgun {Feature}".types
}

// Target dependency extensions
extension Target.Dependency {
    static var mailgun: Self { .target(name: .mailgun) }
    static var messages: Self { .target(name: .messages) }
    static var reporting: Self { .target(name: .reporting) }
    // Clean dependency references matching string names
}

// Product definitions follow pattern
static var mailgun: Product { 
    .library(name: .mailgun, targets: [.mailgun]) 
}
```

### Naming Conventions

- **Modules**: `Mailgun {Feature} Types` (e.g., "Mailgun Messages Types")
- **Files**: `{Feature}.{Component}.swift` (e.g., "Messages.Send.swift")
- **Types**: Nested under feature namespace (e.g., `Mailgun.Messages.Send.Request`)
- **Tests**: `{Feature} Router Tests.swift` for router tests

## Design Principles

1. **Type Safety First**: All API interactions are type-checked at compile time
2. **Testability**: `@DependencyClient` macro enables easy mocking and testing
3. **Modularity**: Each feature is self-contained and independently usable
4. **Flexibility**: Support for multiple implementation strategies
5. **Platform Agnostic**: Pure Swift types work on all platforms
6. **Progressive Enhancement**: Swift 5.10 base with Swift 6 ready
7. **Comprehensive Testing**: Round-trip router testing ensures URL generation and parsing consistency
8. **Clear Separation**: Types package defines contracts, implementation package provides functionality

## Creating New Feature Modules

This section provides a step-by-step guide for adding new Mailgun API features to this package.

### Step 1: Create Module Structure

Create a new directory under `Sources/` following the naming pattern:
```
Sources/Mailgun {Feature} Types/
├── {Feature}.swift           # Main namespace and core types
├── {Feature}.API.swift        # API enum and router
├── {Feature}.Client.swift     # @DependencyClient definition
└── {SubFeature}/             # Optional subdirectories for complex features
```

### Step 2: Define the Namespace

Create the feature namespace enum in `{Feature}.swift`:
```swift
import Foundation

extension Mailgun {
    public enum Feature {}
}
```

### Step 3: Model the API

Define the API enum with all endpoints in `{Feature}.API.swift`:
```swift
extension Mailgun.Feature {
    @CasePathable
    @dynamicMemberLookup
    public enum API: Equatable, Sendable {
        case list(request: ListRequest?)
        case get(id: String)
        case create(request: CreateRequest)
        case update(id: String, request: UpdateRequest)
        case delete(id: String)
    }
}
```

### Step 4: Implement the Router

Add the router implementation in the same file:
```swift
extension Mailgun.Feature.API {
    public struct Router: ParserPrinter, Sendable {
        public init() {}
        
        public var body: some URLRouting.Router<Mailgun.Feature.API> {
            OneOf {
                // Order matters: PUT/DELETE before GET for same paths
                URLRouting.Route(.case(Mailgun.Feature.API.update)) {
                    Method.put
                    Path { "v3" }  // or appropriate version
                    Path.feature
                    Path { Parse(.string) }
                    Body(.form(UpdateRequest.self, decoder: .mailgun))
                }
                
                URLRouting.Route(.case(Mailgun.Feature.API.delete)) {
                    Method.delete
                    Path { "v3" }
                    Path.feature
                    Path { Parse(.string) }
                }
                
                URLRouting.Route(.case(Mailgun.Feature.API.get)) {
                    Method.get
                    Path { "v3" }
                    Path.feature
                    Path { Parse(.string) }
                }
                
                // ... other routes
            }
        }
    }
}

// Define path extensions
extension Path<PathBuilder.Component<String>> {
    nonisolated(unsafe) public static let feature = Path { "feature" }
}
```

### Step 5: Create the Client Interface
If provided with an API reference or documentation, check the documentation for the appropriate Client endpoints to use as closure variables.

Define the client in `{Feature}.Client.swift`:
```swift
extension Mailgun.Feature {
    @DependencyClient
    public struct Client: Sendable {
        @DependencyEndpoint
        public var list: @Sendable (_ request: ListRequest?) async throws -> List.Response
        
        @DependencyEndpoint
        public var get: @Sendable (_ id: String) async throws -> Feature
        
        @DependencyEndpoint
        public var create: @Sendable (_ request: CreateRequest) async throws -> Create.Response
        
        @DependencyEndpoint
        public var update: @Sendable (_ id: String, _ request: UpdateRequest) async throws -> Update.Response
        
        @DependencyEndpoint
        public var delete: @Sendable (_ id: String) async throws -> Void
    }
}
```

### Step 6: Add to Package.swift

Update Package.swift with the new module:
```swift
// Add string extension
extension String {
    static let feature: Self = "Mailgun Feature".types
}

// Add target dependency
extension Target.Dependency {
    static var feature: Self { .target(name: .feature) }
}

// Add target definition
.target(
    name: .feature,
    dependencies: [
        .shared,
        .urlRouting,
        .dependencies
    ]
),

// Add test target
.testTarget(
    name: .feature.tests,
    dependencies: [
        .feature,
        .testing
    ]
)

// Add product
.library(name: .feature, targets: [.feature])
```

### Step 7: Write Tests

Create comprehensive router tests in `Tests/Mailgun {Feature} Types Tests/{Feature} Router Tests.swift`:
```swift
@Suite("{Feature} Router Tests")
struct FeatureRouterTests {
    @Test("Creates correct URL and performs round-trip for list endpoint")
    func testListURL() throws {
        let router: Mailgun.Feature.API.Router = .init()
        let api: Mailgun.Feature.API = .list(request: nil)
        
        // Test URL generation
        let url = router.url(for: api)
        #expect(url.path == "/v3/feature")
        
        // Test round-trip parsing
        let match = try router.match(request: try router.request(for: api))
        #expect(match.is(\\.list))
        #expect(match.list == nil)
    }
    
    // Add tests for all endpoints...
}
```

### Step 8: Update Root Client (Optional)

If the feature should be part of the main client, update `Mailgun.Client`:
```swift
extension Mailgun {
    @DependencyClient
    public struct Client: Sendable {
        // ... existing properties
        public let feature: Feature.Client
        
        public init(
            // ... existing parameters
            feature: Feature.Client
        ) {
            // ... existing assignments
            self.feature = feature
        }
    }
}
```

## Relationship with swift-mailgun Ecosystem

This package provides the types and interfaces that the other packages implement:

- **swift-mailgun-types**: Defines WHAT the API should do (contracts)
- **swift-mailgun-live**: Implements HOW to do it (URLSession implementation)
- **swift-mailgun**: Provides developer-friendly entry point with additional integrations

This separation enables:
- Alternative implementations (e.g., using Alamofire, AsyncHTTPClient)
- Easy testing without network calls
- Clear architectural boundaries
- Independent versioning of types vs implementations
- Sharing types across client and server code
- Progressive enhancement (use swift-mailgun for convenience, drop down when needed)

## Integration with Dependencies

The package integrates with key Point-Free libraries:
- **swift-dependencies**: For dependency injection and testing
- **swift-types-foundation**: For common type definitions (Email, Domain, etc.)
- **swift-url-routing**: For type-safe API route definitions
- **swift-url-form-coding**: For Mailgun-specific form encoding

## Common Pitfalls and Solutions

### 1. Router Ordering Issues

**Problem**: Routes with same path but different HTTP methods fail to parse correctly.

**Solution**: Always order routes by specificity - PUT/DELETE before GET:
```swift
// ❌ Wrong: GET before PUT
URLRouting.Route(.case(API.get)) { Method.get; Path.users; Path { Parse(.string) } }
URLRouting.Route(.case(API.update)) { Method.put; Path.users; Path { Parse(.string) } }

// ✅ Correct: PUT before GET
URLRouting.Route(.case(API.update)) { Method.put; Path.users; Path { Parse(.string) } }
URLRouting.Route(.case(API.get)) { Method.get; Path.users; Path { Parse(.string) } }
```

### 2. Query Parameter Parsing

**Problem**: Using wrong parsers for query parameters causes parsing failures.

**Solution**: Use correct parsers for each type:
```swift
// ❌ Wrong
Field("limit") { Parse(.int) }           // Fails to parse
Field("enabled") { Parse(.bool) }        // Fails to parse

// ✅ Correct
Field("limit") { Digits() }              // For integers
Field("enabled") { Bool.parser() }       // For booleans
```

### 3. Multipart Form Testing

**Problem**: Round-trip tests fail for multipart form routes due to dynamic boundary generation.

**Solution**: Skip round-trip testing for multipart routes, test URL generation only:
```swift
@Test("Creates correct URL for multipart endpoint")
func testMultipartEndpoint() throws {
    let router = API.Router()
    let api = API.upload(data: testData)
    
    // ✅ Test URL generation
    let url = router.url(for: api)
    #expect(url.path == "/v3/upload")
    
    // ❌ Skip round-trip test - dynamic boundary makes it impossible
    // let match = try router.match(request: try router.request(for: api))
}
```

### 4. Optional Query Parameters

**Problem**: Optional query parameters not handled correctly.

**Solution**: Use `Optionally` wrapper with proper memberwise parsing:
```swift
// ✅ Correct pattern for optional query parameters
Optionally {
    Parse(.memberwise(QueryParams.init)) {
        URLRouting.Query {
            Optionally { Field("limit") { Digits() } }
            Optionally { Field("skip") { Digits() } }
        }
    }
}
```

### 5. CasePath Limitations

**Problem**: Dynamic member lookup doesn't work for single-parameter enum cases.

**Solution**: Use direct comparison or labeled access:
```swift
// For single unlabeled parameter
// ❌ Wrong: match.delete?.value
// ✅ Correct: match.delete == "expected-id"

// For single labeled parameter
// ✅ Correct: match.delete?.id == "expected-id"
```

## Implementation Examples

### IP Pools Implementation

The IP Pools module demonstrates several key patterns:

#### 1. API Routing with Optional Query Parameters

```swift
URLRouting.Route(.case(Mailgun.IPPools.API.delete)) {
    Method.delete
    Path { "v1" }
    Path.ipPools
    Path { Parse(.string) }
    Optionally {
        Parse(.memberwise(Mailgun.IPPools.DeleteRequest.init)) {
            URLRouting.Query {
                Optionally {
                    Field("ip") { Parse(.string) }
                }
                Optionally {
                    Field("pool_id") { Parse(.string) }
                }
            }
        }
    }
}
```

Key pattern: Use `Optionally` with `Parse(.memberwise)` for optional query parameter objects.

#### 2. Query Parameter Parsing

Common parsers used in query parameters:
- `Digits()` for integer values (not `Parse(.int)`)
- `Bool.parser()` for boolean values (not `Parse(.bool)`)
- `Parse(.string)` for string values
- Custom parsers for dates and specialized types

Example from Dynamic IP Pools:
```swift
Parse(.memberwise(Mailgun.DynamicIPPools.HistoryListRequest.init)) {
    URLRouting.Query {
        Optionally {
            Field("Limit") { Digits() }
        }
        Optionally {
            Field("include_subaccounts") { Bool.parser() }
        }
        Optionally {
            Field("domain") { Parse(.string) }
        }
    }
}
```

#### 3. Path Extensions

All custom path components must be defined as extensions:
```swift
extension Path<PathBuilder.Component<String>> {
    nonisolated(unsafe) public static let ipPools = Path {
        "ip_pools"
    }
    
    nonisolated(unsafe) public static let domains = Path {
        "domains"
    }
}
```

### Dynamic IP Pools vs Static IP Pools

The package implements both types of IP pool management:

1. **Static IP Pools** (`Mailgun.IPPools`)
   - Manual management of IP assignments
   - Direct control over which IPs belong to which pool
   - CRUD operations for pool management

2. **Dynamic IP Pools** (`Mailgun.DynamicIPPools`)
   - Automatic IP assignment based on health checks
   - History tracking of domain movements between pools
   - Override management for manual control when needed

## Testing Patterns

### 1. Router Round-Trip Testing

All router tests should verify both URL generation and parsing (round-trip):

```swift
@Test("Creates correct URL for sending message")
func testSendMessageURL() throws {
    let router: Mailgun.Messages.API.Router = .init()
    
    let request = Mailgun.Messages.Send.Request(
        from: .init("sender@test.com"),
        to: [.init("recipient@test.com")],
        subject: "Test Subject"
    )
    
    let api: Mailgun.Messages.API = .send(
        domain: try .init("test.domain.com"),
        request: request
    )
    
    // Test URL generation
    let url = router.url(for: api)
    #expect(url.path == "/v3/test.domain.com/messages")
    
    // Test round-trip parsing
    let match: Mailgun.Messages.API = try router.match(request: try router.request(for: api))
    #expect(match.is(\.send))
    #expect(match.send?.domain == (try .init("test.domain.com")))
    #expect(match.send?.request.from.rawValue == "sender@test.com")
}
```

### 2. CasePath Pattern for Enum Matching

Use CasePaths for cleaner enum case matching in tests:

```swift
// Preferred: Using CasePath pattern
#expect(match.is(\.send))
#expect(match.send?.domain == expectedDomain)
#expect(match.send?.request.subject == "Test")

// Instead of: if-case-let pattern
if case let .send(domain: receivedDomain, request: receivedRequest) = match {
    #expect(receivedDomain == expectedDomain)
    #expect(receivedRequest.subject == "Test")
}
```

### 3. Router Ordering Considerations

**Critical**: Route order matters in URLRouting. More specific routes must come before general ones:

```swift
public var body: some URLRouting.Router<API> {
    OneOf {
        // PUT/DELETE routes MUST come before GET routes with same path
        URLRouting.Route(.case(API.updateMember)) {  // PUT /lists/{email}/members/{email}
            Method.put
            // ...
        }
        
        URLRouting.Route(.case(API.deleteMember)) {  // DELETE /lists/{email}/members/{email}
            Method.delete
            // ...
        }
        
        URLRouting.Route(.case(API.getMember)) {     // GET /lists/{email}/members/{email}
            Method.get
            // ...
        }
    }
}
```

### 4. Multipart Form Limitations

Routes using multipart form encoding with dynamic boundaries cannot be fully round-trip tested:

```swift
@Test("Creates correct URL for updating member")
func testUpdateMemberURL() throws {
    let router: Mailgun.Lists.API.Router = .init()
    let api: Mailgun.Lists.API = .updateMember(...)
    
    // Can test URL generation
    let url = router.url(for: api)
    #expect(url.path == "/v3/lists/developers@test.com/members/member@example.com")
    
    // Cannot test round-trip due to dynamic multipart boundary generation
    // Each request generates a unique boundary ID that cannot be predicted
}
```

### 5. Test Organization

Tests follow a consistent structure:
```swift
@Suite("Feature Router Tests")
struct FeatureRouterTests {
    @Test("Creates correct URL for specific endpoint")
    func testSpecificEndpointURL() throws {
        let router: Mailgun.Feature.API.Router = .init()
        
        // 1. Create API enum case
        let api: Mailgun.Feature.API = .endpoint(...)
        
        // 2. Test URL generation
        let url = router.url(for: api)
        #expect(url.path == "/expected/path")
        
        // 3. Test round-trip parsing (when possible)
        let match = try router.match(request: try router.request(for: api))
        #expect(match.is(\.endpoint))
        
        // 4. Verify parsed values
        #expect(match.endpoint?.parameter == expectedValue)
    }
}
```

Key testing practices:
- Use `@Suite` and `@Test` attributes from Swift Testing
- Test URL generation for all API endpoints
- Verify round-trip parsing when possible
- Use CasePath pattern for enum matching
- Document limitations (e.g., multipart forms)
- Group related tests in suites
