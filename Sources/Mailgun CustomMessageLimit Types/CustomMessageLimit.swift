//
//  File.swift
//  coenttb-mailgun
//
//  Created by Coen ten Thije Boonkkamp on 24/12/2024.
//

@_exported import Mailgun_Types_Shared
extension Mailgun {
    public enum CustomMessageLimit {}
}

// MARK: - Monthly Limit Management
extension Mailgun.CustomMessageLimit {
    public enum Monthly {}
}

extension Mailgun.CustomMessageLimit.Monthly {
    // MARK: - Get Monthly Limit
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

// MARK: - Set Monthly Limit
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

// MARK: - Delete Monthly Limit
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

// MARK: - Enable Account
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
