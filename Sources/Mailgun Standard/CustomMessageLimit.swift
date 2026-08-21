extension Mailgun {
    public enum CustomMessageLimit {}
}

extension Mailgun.CustomMessageLimit {
    public enum Monthly {}
}

extension Mailgun.CustomMessageLimit.Monthly {

    public enum Get {}
}

extension Mailgun.CustomMessageLimit.Monthly.Get {
    public struct Response: Sendable, Decodable, Equatable {
        public let limit: Int
        public let current: Int
        public let period: String

        public init(
            limit: Int,
            current: Int,
            period: String
        ) {
            self.limit = limit
            self.current = current
            self.period = period
        }
    }
}

extension Mailgun.CustomMessageLimit.Monthly {
    public enum Set {}
}

extension Mailgun.CustomMessageLimit.Monthly.Set {
    public struct Request: Sendable, Codable, Equatable {
        public let limit: Int

        public init(limit: Int) {
            self.limit = limit
        }
    }

    public struct Response: Sendable, Decodable, Equatable {
        public let success: Bool

        public init(success: Bool) {
            self.success = success
        }
    }
}

extension Mailgun.CustomMessageLimit.Monthly {
    public enum Delete {}
}

extension Mailgun.CustomMessageLimit.Monthly.Delete {
    public struct Response: Sendable, Decodable, Equatable {
        public let success: Bool

        public init(success: Bool) {
            self.success = success
        }
    }
}

extension Mailgun.CustomMessageLimit {
    public enum EnableAccount {}
}

extension Mailgun.CustomMessageLimit.EnableAccount {
    public struct Response: Sendable, Decodable, Equatable {
        public let success: Bool

        public init(success: Bool) {
            self.success = success
        }
    }
}
