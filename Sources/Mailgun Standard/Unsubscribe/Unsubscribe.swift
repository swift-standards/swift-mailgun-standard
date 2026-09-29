public import EmailAddress_Standard
import EmailAddress_Foundation_Integration

extension Mailgun.Suppressions {
    public enum Unsubscribe {}
}

extension Mailgun.Suppressions.Unsubscribe {
    public struct Record: Sendable, Codable, Equatable {
        public let address: EmailAddress
        public let tags: [String]
        public let createdAt: String

        public init(
            address: EmailAddress,
            tags: [String],
            createdAt: String
        ) {
            self.address = address
            self.tags = tags
            self.createdAt = createdAt
        }

        private enum CodingKeys: String, CodingKey {
            case address
            case tags
            case createdAt = "created_at"
        }
    }
}

extension Mailgun.Suppressions.Unsubscribe {
    public enum Import {}
}

extension Mailgun.Suppressions.Unsubscribe.Import {
    public struct Response: Sendable, Codable, Equatable {
        public let message: String

        public init(message: String) {
            self.message = message
        }
    }
}

extension Mailgun.Suppressions.Unsubscribe {
    public enum Get {}
}

extension Mailgun.Suppressions.Unsubscribe.Get {
    public struct Response: Sendable, Codable, Equatable {
        public let address: EmailAddress
        public let tags: [String]
        public let createdAt: String

        public init(
            address: EmailAddress,
            tags: [String],
            createdAt: String
        ) {
            self.address = address
            self.tags = tags
            self.createdAt = createdAt
        }

        private enum CodingKeys: String, CodingKey {
            case address
            case tags
            case createdAt = "created_at"
        }
    }
}

extension Mailgun.Suppressions.Unsubscribe {
    public enum Create {}
}

extension Mailgun.Suppressions.Unsubscribe.Create {

    public struct Request: Sendable, Codable, Equatable {
        public let address: EmailAddress
        public let tags: [String]?
        public let createdAt: String?

        public init(
            address: EmailAddress,
            tags: [String]? = nil,
            createdAt: String? = nil
        ) {
            self.address = address
            self.tags = tags
            self.createdAt = createdAt
        }

        private enum CodingKeys: String, CodingKey {
            case address
            case tags
            case createdAt = "created_at"
        }
    }

    public struct Response: Sendable, Codable, Equatable {
        public let message: String

        public init(message: String) {
            self.message = message
        }
    }
}

extension Mailgun.Suppressions.Unsubscribe {
    public enum Delete {}
}

extension Mailgun.Suppressions.Unsubscribe.Delete {
    public struct Response: Sendable, Codable, Equatable {
        public let message: String
        public let address: EmailAddress

        public init(
            message: String,
            address: EmailAddress
        ) {
            self.message = message
            self.address = address
        }
    }
}

extension Mailgun.Suppressions.Unsubscribe {
    public enum DeleteAll {}
}

extension Mailgun.Suppressions.Unsubscribe.DeleteAll {
    public struct Response: Sendable, Codable, Equatable {
        public let message: String

        public init(
            message: String
        ) {
            self.message = message
        }
    }
}

extension Mailgun.Suppressions.Unsubscribe {
    public enum List {}
}

extension Mailgun.Suppressions.Unsubscribe.List {
    public struct Request: Sendable, Codable, Equatable {
        public let address: EmailAddress?
        public let term: String?
        public let limit: Int?
        public let page: String?

        public init(
            address: EmailAddress? = nil,
            term: String? = nil,
            limit: Int? = nil,
            page: String? = nil
        ) {
            self.address = address
            self.term = term
            self.limit = limit
            self.page = page
        }
    }

    public struct Response: Sendable, Codable, Equatable {
        public let items: [Mailgun.Suppressions.Unsubscribe.Record]
        public let paging: Paging

        public init(
            items: [Mailgun.Suppressions.Unsubscribe.Record],
            paging: Paging
        ) {
            self.items = items
            self.paging = paging
        }
    }

    public struct Paging: Sendable, Codable, Equatable {
        public let previous: String?
        public let first: String
        public let next: String?
        public let last: String

        public init(
            previous: String?,
            first: String,
            next: String?,
            last: String
        ) {
            self.previous = previous
            self.first = first
            self.next = next
            self.last = last
        }
    }
}
