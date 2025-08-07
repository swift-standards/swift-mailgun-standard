// Complaints.swift
import EmailAddress
@_exported import Mailgun_Types_Shared

extension Mailgun.Suppressions {
    public enum Complaints {}
}

// MARK: - Namespace markers for operations
extension Mailgun.Suppressions.Complaints {
    public enum Get {}
}

extension Mailgun.Suppressions.Complaints.Get {
    public typealias Response = Mailgun.Suppressions.Complaints.Record
}

extension Mailgun.Suppressions.Complaints {
    public struct Record: Sendable, Codable, Equatable {
        public let address: EmailAddress
        public let createdAt: String

        public init(
            address: EmailAddress,
            createdAt: String
        ) {
            self.address = address
            self.createdAt = createdAt
        }

        private enum CodingKeys: String, CodingKey {
            case address
            case createdAt = "created_at"
        }
    }
}

// MARK: - Import Operation
extension Mailgun.Suppressions.Complaints {
    public enum Import {}
}

extension Mailgun.Suppressions.Complaints.Import {
    public struct Request: Sendable, Codable, Equatable {
        public let file: Foundation.Data

        public init(file: Foundation.Data) {
            self.file = file
        }
    }

    public struct Response: Sendable, Codable, Equatable {
        public let message: String

        public init(message: String) {
            self.message = message
        }
    }
}

// MARK: - Create Operation
extension Mailgun.Suppressions.Complaints {
    public enum Create {}
}

extension Mailgun.Suppressions.Complaints.Create {
    // For single record creation via form-data
    public struct Request: Sendable, Codable, Equatable {
        public let address: EmailAddress
        public let createdAt: String?

        public init(
            address: EmailAddress,
            createdAt: String? = nil
        ) {
            self.address = address
            self.createdAt = createdAt
        }

        private enum CodingKeys: String, CodingKey {
            case address
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

// MARK: - Delete Operation
extension Mailgun.Suppressions.Complaints {
    public enum Delete {}
}

extension Mailgun.Suppressions.Complaints.Delete {
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

extension Mailgun.Suppressions.Complaints.Delete {
    public enum All {
        public struct Response: Sendable, Codable, Equatable {
            public let message: String

            public init(
                message: String
            ) {
                self.message = message
            }
        }
    }
}

// MARK: - List Operation
extension Mailgun.Suppressions.Complaints {
    public enum List {}
}

extension Mailgun.Suppressions.Complaints.List {
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
        public let items: [Mailgun.Suppressions.Complaints.Record]
        public let paging: Paging

        public init(
            items: [Mailgun.Suppressions.Complaints.Record],
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
