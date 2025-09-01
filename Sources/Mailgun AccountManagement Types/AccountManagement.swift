//
//  File.swift
//  swift-mailgun
//
//  Created by Coen ten Thije Boonkkamp on 24/12/2024.
//

import EmailAddress
@_exported import Mailgun_Types_Shared
extension Mailgun {
    public enum AccountManagement {}
}

extension Mailgun.AccountManagement {
    public enum Update {}
}

extension Mailgun.AccountManagement.Update {
    public struct Request: Sendable, Codable, Equatable {
        public let name: String?
        public let inactiveSessionTimeout: Int?
        public let absoluteSessionTimeout: Int?
        public let logoutRedirectUrl: String?

        public init(
            name: String? = nil,
            inactiveSessionTimeout: Int? = nil,
            absoluteSessionTimeout: Int? = nil,
            logoutRedirectUrl: String? = nil
        ) {
            self.name = name
            self.inactiveSessionTimeout = inactiveSessionTimeout
            self.absoluteSessionTimeout = absoluteSessionTimeout
            self.logoutRedirectUrl = logoutRedirectUrl
        }

        private enum CodingKeys: String, CodingKey {
            case name
            case inactiveSessionTimeout = "inactive_session_timeout"
            case absoluteSessionTimeout = "absolute_session_timeout"
            case logoutRedirectUrl = "logout_redirect_url"
        }
    }

    public struct Response: Sendable, Decodable, Equatable {
        public let message: String

        public init(message: String) {
            self.message = message
        }
    }
}

extension Mailgun.AccountManagement {
    public enum HttpSigningKey {}
}

extension Mailgun.AccountManagement.HttpSigningKey {
    public struct Get {}
    public struct Regenerate {}
}

extension Mailgun.AccountManagement.HttpSigningKey.Get {
    public struct Response: Sendable, Decodable, Equatable {
        public let message: String?
        public let httpSigningKey: String

        public init(
            message: String? = nil,
            httpSigningKey: String
        ) {
            self.message = message
            self.httpSigningKey = httpSigningKey
        }

        private enum CodingKeys: String, CodingKey {
            case message
            case httpSigningKey = "http_signing_key"
        }
    }
}

extension Mailgun.AccountManagement.HttpSigningKey.Regenerate {
    public struct Response: Sendable, Decodable, Equatable {
        public let message: String
        public let httpSigningKey: String

        public init(
            message: String,
            httpSigningKey: String
        ) {
            self.message = message
            self.httpSigningKey = httpSigningKey
        }

        private enum CodingKeys: String, CodingKey {
            case message
            case httpSigningKey = "http_signing_key"
        }
    }
}

extension Mailgun.AccountManagement {
    public enum Sandbox {}
}

extension Mailgun.AccountManagement.Sandbox {
    public enum Auth {}
}

extension Mailgun.AccountManagement.Sandbox.Auth {
    public enum Recipients {}
}

extension Mailgun.AccountManagement.Sandbox.Auth.Recipients {
    public struct Recipient: Sendable, Decodable, Equatable {
        public let email: EmailAddress
        public let activated: Bool

        public init(email: EmailAddress, activated: Bool) {
            self.email = email
            self.activated = activated
        }
    }

    public enum List {}
    public enum Add {}
    public enum Delete {}
}

extension Mailgun.AccountManagement.Sandbox.Auth.Recipients.List {
    public struct Response: Sendable, Decodable, Equatable {
        public let recipients: [Mailgun.AccountManagement.Sandbox.Auth.Recipients.Recipient]

        public init(recipients: [Mailgun.AccountManagement.Sandbox.Auth.Recipients.Recipient]) {
            self.recipients = recipients
        }
    }
}

extension Mailgun.AccountManagement.Sandbox.Auth.Recipients.Add {
    public struct Request: Sendable, Codable, Equatable {
        public let email: EmailAddress

        public init(email: EmailAddress) {
            self.email = email
        }
    }

    public struct Response: Sendable, Decodable, Equatable {
        public let recipient: Mailgun.AccountManagement.Sandbox.Auth.Recipients.Recipient

        public init(recipient: Mailgun.AccountManagement.Sandbox.Auth.Recipients.Recipient) {
            self.recipient = recipient
        }
    }
}

extension Mailgun.AccountManagement.Sandbox.Auth.Recipients.Delete {
    public struct Response: Sendable, Decodable, Equatable {
        public let message: String

        public init(message: String) {
            self.message = message
        }
    }
}

extension Mailgun.AccountManagement {
    public enum ResendActivationEmail {}
}

extension Mailgun.AccountManagement.ResendActivationEmail {
    public struct Response: Sendable, Decodable, Equatable {
        public let success: Bool

        public init(success: Bool) {
            self.success = success
        }
    }
}

extension Mailgun.AccountManagement {
    public enum SAML {}
}

extension Mailgun.AccountManagement.SAML {
    public enum Organization {}
}

extension Mailgun.AccountManagement.SAML.Organization {
    public enum Get {}
    public enum Add {}
}

extension Mailgun.AccountManagement.SAML.Organization.Get {
    public struct Response: Sendable, Decodable, Equatable {
        public let samlOrgId: String

        public init(samlOrgId: String) {
            self.samlOrgId = samlOrgId
        }

        private enum CodingKeys: String, CodingKey {
            case samlOrgId = "saml_org_id"
        }
    }
}

extension Mailgun.AccountManagement.SAML.Organization.Add {
    public struct Request: Sendable, Codable, Equatable {
        public let userId: String
        public let domain: String?

        public init(
            userId: String,
            domain: String? = nil
        ) {
            self.userId = userId
            self.domain = domain
        }

        private enum CodingKeys: String, CodingKey {
            case userId = "user_id"
            case domain
        }
    }

    public struct Response: Sendable, Decodable, Equatable {
        public let message: String
        public let samlOrgId: String

        public init(
            message: String,
            samlOrgId: String
        ) {
            self.message = message
            self.samlOrgId = samlOrgId
        }

        private enum CodingKeys: String, CodingKey {
            case message
            case samlOrgId = "saml_org_id"
        }
    }
}
