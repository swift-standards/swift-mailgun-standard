public import Byte

extension Byte: @retroactive Codable {

    public init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.init(bitPattern: try container.decode(UInt8.self))
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(bitPattern)
    }
}
