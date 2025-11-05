//
//  File.swift
//  swift-mailgun
//
//  Created by Coen ten Thije Boonkkamp on 24/12/2024.
//

@_exported import Mailgun_Types_Shared

extension Mailgun {
    public enum IPs {}
}

// MARK: - Core Types

extension Mailgun.IPs {
    public struct IP: Sendable, Codable, Equatable {
        public let ip: String
        public let dedicated: Bool
        public let enabled: Bool?
        public let isOnWarmup: Bool?
        public let rdns: String?

        public init(
            ip: String,
            dedicated: Bool,
            enabled: Bool? = nil,
            isOnWarmup: Bool? = nil,
            rdns: String? = nil
        ) {
            self.ip = ip
            self.dedicated = dedicated
            self.enabled = enabled
            self.isOnWarmup = isOnWarmup
            self.rdns = rdns
        }

        private enum CodingKeys: String, CodingKey {
            case ip
            case dedicated
            case enabled
            case isOnWarmup = "is_on_warmup"
            case rdns
        }
    }
}

// MARK: - List Operation

extension Mailgun.IPs {
    public enum List {}
}

extension Mailgun.IPs.List {
    public struct Response: Sendable, Codable, Equatable {
        public let details: [Mailgun.IPs.IP]?
        public let items: [String]
        public let totalCount: Int

        public init(
            details: [Mailgun.IPs.IP]? = nil,
            items: [String],
            totalCount: Int
        ) {
            self.details = details
            self.items = items
            self.totalCount = totalCount
        }

        private enum CodingKeys: String, CodingKey {
            case details
            case items
            case totalCount = "total_count"
        }
    }
}

// MARK: - Domain List Operation

extension Mailgun.IPs {
    public enum DomainList {}
}

extension Mailgun.IPs.DomainList {
    public struct Response: Sendable, Codable, Equatable {
        public let items: [String]
        public let totalCount: Int

        public init(
            items: [String],
            totalCount: Int
        ) {
            self.items = items
            self.totalCount = totalCount
        }

        private enum CodingKeys: String, CodingKey {
            case items
            case totalCount = "total_count"
        }
    }
}

// MARK: - Assign Domain Operation

extension Mailgun.IPs {
    public enum AssignDomain {}
}

extension Mailgun.IPs.AssignDomain {
    public struct Request: Sendable, Codable, Equatable {
        public let domain: String

        public init(domain: String) {
            self.domain = domain
        }
    }

    public struct Response: Sendable, Codable, Equatable {
        public let message: String

        public init(message: String) {
            self.message = message
        }
    }
}

// MARK: - IP Band Operation

extension Mailgun.IPs {
    public enum IPBand {}
}

extension Mailgun.IPs.IPBand {
    public struct Request: Sendable, Codable, Equatable {
        public let ipBand: String

        public init(ipBand: String) {
            self.ipBand = ipBand
        }

        private enum CodingKeys: String, CodingKey {
            case ipBand = "ip_band"
        }
    }

    public struct Response: Sendable, Codable, Equatable {
        public let message: String

        public init(message: String) {
            self.message = message
        }
    }
}

// MARK: - Request New IPs Operation

extension Mailgun.IPs {
    public enum RequestNew {}
}

extension Mailgun.IPs.RequestNew {
    public struct Request: Sendable, Codable, Equatable {
        public let count: Int

        public init(count: Int) {
            self.count = count
        }
    }

    public struct Response: Sendable, Codable, Equatable {
        public let requested: Int?
        public let allowed: Allowed?

        public init(
            requested: Int? = nil,
            allowed: Allowed? = nil
        ) {
            self.requested = requested
            self.allowed = allowed
        }

        public struct Allowed: Sendable, Codable, Equatable {
            public let dedicated: Int
            public let shared: Int

            public init(
                dedicated: Int,
                shared: Int
            ) {
                self.dedicated = dedicated
                self.shared = shared
            }
        }
    }
}

// MARK: - Delete Operation

extension Mailgun.IPs {
    public enum Delete {}
}

extension Mailgun.IPs.Delete {
    public struct Response: Sendable, Codable, Equatable {
        public let message: String

        public init(message: String) {
            self.message = message
        }
    }
}
