import Time_Primitive

// `Time.Epoch` (swift-time-primitives) is Sendable/Equatable/Hashable but not Codable
// upstream — its own product only vends named reference-point constants (`.unix`, `.ntp`,
// ...), never round-trips one through the wire. This package uses `Time.Epoch` to model
// every Mailgun field whose wire form is unix-epoch seconds, so every such field needs to
// decode/encode. Conformance here forwards to the already-Codable `Time` it wraps.
//
// REASON: `Time.Epoch` is owned by swift-primitives/swift-time-primitives and `Codable` by
// the standard library; this package owns neither, so the conformance is retroactive.
extension Time.Epoch: @retroactive Codable {
    // REASON: `Swift.Decodable.init(from:)` is declared with untyped `throws`
    // upstream; a conforming implementation is signature-forced and cannot
    // express `throws(E)`.
    // swiftlint:disable:next typed_throws_required
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.init(referenceDate: try container.decode(Time.self))
    }

    // REASON: `Swift.Encodable.encode(to:)` is declared with untyped `throws`
    // upstream; a conforming implementation is signature-forced and cannot
    // express `throws(E)`.
    // swiftlint:disable:next typed_throws_required
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(referenceDate)
    }
}
