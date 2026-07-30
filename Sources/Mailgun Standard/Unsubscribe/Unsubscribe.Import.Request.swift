extension Mailgun.Suppressions.Unsubscribe.Import {
    public struct Request: Sendable, Codable, Equatable {
        public let file: [UInt8]

        public init(file: [UInt8]) {
            self.file = file
        }
    }
}
