//
//  File.swift
//  swift-mailgun
//
//  Created by Coen ten Thije Boonkkamp on 24/12/2024.
//

@_exported import Mailgun_Types_Shared

extension Mailgun {
    public enum IPAllowlist {}
}

extension Mailgun.IPAllowlist {
    public struct Entry: Sendable, Codable, Equatable {
        public let ipAddress: String
        public let description: String

        public init(
            ipAddress: String,
            description: String
        ) {
            self.ipAddress = ipAddress
            self.description = description
        }

        private enum CodingKeys: String, CodingKey {
            case ipAddress = "ip_address"
            case description
        }
    }
}

extension Mailgun.IPAllowlist {
    public struct ListResponse: Sendable, Decodable, Equatable {
        public let addresses: [Entry]

        public init(addresses: [Entry]) {
            self.addresses = addresses
        }
    }
}

extension Mailgun.IPAllowlist {
    public struct AddRequest: Sendable, Codable, Equatable {
        public let address: String
        public let description: String

        public init(
            address: String,
            description: String
        ) {
            self.address = address
            self.description = description
        }
    }
}

extension Mailgun.IPAllowlist {
    public struct UpdateRequest: Sendable, Codable, Equatable {
        public let address: String
        public let description: String

        public init(
            address: String,
            description: String
        ) {
            self.address = address
            self.description = description
        }
    }
}

extension Mailgun.IPAllowlist {
    public struct DeleteRequest: Sendable, Codable, Equatable {
        public let address: String

        public init(address: String) {
            self.address = address
        }
    }
}

extension Mailgun.IPAllowlist {
    public struct SuccessResponse: Sendable, Decodable, Equatable {
        public let message: String?

        public init(message: String? = nil) {
            self.message = message
        }
    }
}
