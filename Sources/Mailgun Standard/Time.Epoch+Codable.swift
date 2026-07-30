import Time_Primitive

// `Time.Epoch` (swift-time-primitives) is Sendable/Equatable/Hashable but not Codable
// upstream — its own product only vends named reference-point constants (`.unix`, `.ntp`,
// ...), never round-trips one through the wire. This package uses `Time.Epoch` to model
// every Mailgun field whose wire form is unix-epoch seconds, so every such field needs to
// decode/encode. Conformance here forwards to the already-Codable `Time` it wraps.
extension Time.Epoch: Codable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.init(referenceDate: try container.decode(Time.self))
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(referenceDate)
    }
}
