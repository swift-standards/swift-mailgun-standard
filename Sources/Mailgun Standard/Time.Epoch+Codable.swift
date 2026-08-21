import Time_Primitive

extension Time.Epoch: @retroactive Codable {

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.init(referenceDate: try container.decode(Time.self))
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(referenceDate)
    }
}
