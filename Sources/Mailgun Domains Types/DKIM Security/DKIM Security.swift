//
//  File.swift
//  coenttb-mailgun
//
//  Created by Coen ten Thije Boonkkamp on 24/12/2024.
//

@_exported import Mailgun_Types_Shared

extension Mailgun.Domains {
    public enum DKIM_Security {}
}

// MARK: - Rotation Update

extension Mailgun.Domains.DKIM_Security {
    public enum Rotation {}
}

extension Mailgun.Domains.DKIM_Security.Rotation {
    public enum Update {}
}

extension Mailgun.Domains.DKIM_Security.Rotation.Update {
    public struct Request: Sendable, Codable, Equatable {
        public let rotationEnabled: Bool
        public let rotationInterval: String?

        public init(
            rotationEnabled: Bool,
            rotationInterval: String? = nil
        ) {
            self.rotationEnabled = rotationEnabled
            self.rotationInterval = rotationInterval
        }

        private enum CodingKeys: String, CodingKey {
            case rotationEnabled = "rotation_enabled"
            case rotationInterval = "rotation_interval"
        }
    }

    public struct Response: Sendable, Codable, Equatable {
        public let message: String

        public init(message: String) {
            self.message = message
        }
    }
}

// MARK: - Manual Rotation

extension Mailgun.Domains.DKIM_Security.Rotation {
    public enum Manual {}
}

extension Mailgun.Domains.DKIM_Security.Rotation.Manual {
    public struct Response: Sendable, Codable, Equatable {
        public let message: String

        public init(message: String) {
            self.message = message
        }
    }
}
