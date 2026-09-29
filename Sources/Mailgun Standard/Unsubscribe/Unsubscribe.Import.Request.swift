public import Byte

extension Mailgun.Suppressions.Unsubscribe.Import {
    public struct Request: Sendable, Codable, Equatable {
        public let file: [Byte]

        public init(file: [Byte]) {
            self.file = file
        }
    }
}
