//
//  File.swift
//  swift-mailgun
//
//  Created by Coen ten Thije Boonkkamp on 24/12/2024.
//

@_exported import Mailgun_Types_Shared

extension Mailgun {
    public enum Credentials {}
}

extension Mailgun.Credentials {
    public struct Credential: Sendable, Codable, Equatable {
        public let login: String
        public let mailbox: String
        public let createdAt: String
        public let sizeBytes: String?

        public init(
            login: String,
            mailbox: String,
            createdAt: String,
            sizeBytes: String? = nil
        ) {
            self.login = login
            self.mailbox = mailbox
            self.createdAt = createdAt
            self.sizeBytes = sizeBytes
        }

        private enum CodingKeys: String, CodingKey {
            case login
            case mailbox
            case createdAt = "created_at"
            case sizeBytes = "size_bytes"
        }
    }
}

extension Mailgun.Credentials {
    public enum List {}
}

extension Mailgun.Credentials.List {
    public struct Request: Sendable, Codable, Equatable {
        public let skip: Int?
        public let limit: Int?

        public init(
            skip: Int? = nil,
            limit: Int? = nil
        ) {
            self.skip = skip
            self.limit = limit
        }
    }

    public struct Response: Sendable, Decodable, Equatable {
        public let totalCount: Int
        public let items: [Mailgun.Credentials.Credential]

        public init(
            totalCount: Int,
            items: [Mailgun.Credentials.Credential]
        ) {
            self.totalCount = totalCount
            self.items = items
        }

        private enum CodingKeys: String, CodingKey {
            case totalCount = "total_count"
            case items
        }
    }
}

extension Mailgun.Credentials {
    public enum Create {}
}

extension Mailgun.Credentials.Create {
    public struct Request: Sendable, Codable, Equatable {
        public let login: String?
        public let mailbox: String?
        public let password: String?
        public let system: Bool?

        public init(
            login: String? = nil,
            mailbox: String? = nil,
            password: String? = nil,
            system: Bool? = nil
        ) {
            self.login = login
            self.mailbox = mailbox
            self.password = password
            self.system = system
        }
    }

    public struct Response: Sendable, Decodable, Equatable {
        public let message: String
        public let note: String?
        public let credentials: [String: String]?

        public init(
            message: String,
            note: String? = nil,
            credentials: [String: String]? = nil
        ) {
            self.message = message
            self.note = note
            self.credentials = credentials
        }
    }
}

extension Mailgun.Credentials {
    public enum Update {}
}

extension Mailgun.Credentials.Update {
    public struct Request: Sendable, Codable, Equatable {
        public let password: String?

        public init(password: String? = nil) {
            self.password = password
        }
    }

    public struct Response: Sendable, Decodable, Equatable {
        public let message: String
        public let note: String?
        public let credentials: [String: String]?

        public init(
            message: String,
            note: String? = nil,
            credentials: [String: String]? = nil
        ) {
            self.message = message
            self.note = note
            self.credentials = credentials
        }
    }
}

extension Mailgun.Credentials {
    public enum Delete {}
}

extension Mailgun.Credentials.Delete {
    public struct Response: Sendable, Decodable, Equatable {
        public let message: String
        public let spec: String?
        public let count: Int?

        public init(
            message: String,
            spec: String? = nil,
            count: Int? = nil
        ) {
            self.message = message
            self.spec = spec
            self.count = count
        }
    }
}

extension Mailgun.Credentials {
    public enum Mailbox {}
}

extension Mailgun.Credentials.Mailbox {
    public enum Update {}
}

extension Mailgun.Credentials.Mailbox.Update {
    public struct Request: Sendable, Codable, Equatable {
        public let password: String?

        public init(password: String? = nil) {
            self.password = password
        }
    }

    public struct Response: Sendable, Decodable, Equatable {
        public let message: String
        public let note: String?
        public let credentials: [String: String]?

        public init(
            message: String,
            note: String? = nil,
            credentials: [String: String]? = nil
        ) {
            self.message = message
            self.note = note
            self.credentials = credentials
        }
    }
}
