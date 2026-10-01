public import Time

extension Mailgun {
    public enum IPAddressWarmup {}
}

extension Mailgun.IPAddressWarmup {
    public struct IPWarmup: Sendable, Codable, Equatable {
        public let ip: String
        public let enabled: Bool
        public let created: Time.Instant
        public let modified: Time.Instant?
        public let startedAt: Time.Instant?
        public let completedAt: Time.Instant?
        public let volumeDailyCapacity: Int?
        public let volumeCurrentDaily: Int?
        public let status: Status?

        public init(
            ip: String,
            enabled: Bool,
            created: Time.Instant,
            modified: Time.Instant? = nil,
            startedAt: Time.Instant? = nil,
            completedAt: Time.Instant? = nil,
            volumeDailyCapacity: Int? = nil,
            volumeCurrentDaily: Int? = nil,
            status: Status? = nil
        ) {
            self.ip = ip
            self.enabled = enabled
            self.created = created
            self.modified = modified
            self.startedAt = startedAt
            self.completedAt = completedAt
            self.volumeDailyCapacity = volumeDailyCapacity
            self.volumeCurrentDaily = volumeCurrentDaily
            self.status = status
        }

        private enum CodingKeys: String, CodingKey {
            case ip
            case enabled
            case created
            case modified
            case startedAt = "started_at"
            case completedAt = "completed_at"
            case volumeDailyCapacity = "volume_daily_capacity"
            case volumeCurrentDaily = "volume_current_daily"
            case status
        }

        public enum Status: String, Sendable, Codable, Equatable {
            case active
            case scheduled
            case completed
            case paused
        }
    }
}

extension Mailgun.IPAddressWarmup {
    public enum List {}
}

extension Mailgun.IPAddressWarmup.List {
    public struct Response: Sendable, Codable, Equatable {
        public let items: [Mailgun.IPAddressWarmup.IPWarmup]
        public let paging: Paging?

        public init(
            items: [Mailgun.IPAddressWarmup.IPWarmup],
            paging: Paging? = nil
        ) {
            self.items = items
            self.paging = paging
        }

        public struct Paging: Sendable, Codable, Equatable {
            public let previous: String
            public let first: String
            public let next: String
            public let last: String

            public init(
                previous: String,
                first: String,
                next: String,
                last: String
            ) {
                self.previous = previous
                self.first = first
                self.next = next
                self.last = last
            }
        }
    }
}

extension Mailgun.IPAddressWarmup {
    public enum Create {}
}

extension Mailgun.IPAddressWarmup.Create {
    public struct Request: Sendable, Codable, Equatable {
        public let enabled: Bool?
        public let volumeDailyCapacity: Int?

        public init(
            enabled: Bool? = nil,
            volumeDailyCapacity: Int? = nil
        ) {
            self.enabled = enabled
            self.volumeDailyCapacity = volumeDailyCapacity
        }

        private enum CodingKeys: String, CodingKey {
            case enabled
            case volumeDailyCapacity = "volume_daily_capacity"
        }
    }

    public struct Response: Sendable, Codable, Equatable {
        public let message: String
        public let ip: String

        public init(
            message: String,
            ip: String
        ) {
            self.message = message
            self.ip = ip
        }
    }
}

extension Mailgun.IPAddressWarmup {
    public enum Delete {}
}

extension Mailgun.IPAddressWarmup.Delete {
    public struct Response: Sendable, Codable, Equatable {
        public let message: String

        public init(message: String) {
            self.message = message
        }
    }
}
