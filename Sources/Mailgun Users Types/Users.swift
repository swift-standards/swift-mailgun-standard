//
//  File.swift
//  coenttb-mailgun
//
//  Created by Coen ten Thije Boonkkamp on 24/12/2024.
//

@_exported import Mailgun_Types_Shared

import Foundation

extension Mailgun {
    public enum Users {}
}

// MARK: - Core Types
extension Mailgun.Users {
    public struct User: Sendable, Decodable, Equatable {
        public let id: String
        public let activated: Bool?
        public let name: String?
        public let isDisabled: Bool?
        public let email: EmailAddress
        public let emailDetails: EmailDetails?
        public let role: String?
        public let accountId: String?
        public let openedIp: String?
        public let isMaster: Bool?
        public let metadata: [String: String]?
        public let tfaEnabled: Bool?
        public let tfaActive: Bool?
        public let tfaCreatedAt: String?
        public let passwordUpdatedAt: String?
        public let preferences: Preferences?
        public let auth: AuthDetails?
        public let githubUserId: String?
        public let salesforceUserId: String?
        public let migrationStatus: String?
        
        public init(
            id: String,
            activated: Bool? = nil,
            name: String? = nil,
            isDisabled: Bool? = nil,
            email: EmailAddress,
            emailDetails: EmailDetails? = nil,
            role: String? = nil,
            accountId: String? = nil,
            openedIp: String? = nil,
            isMaster: Bool? = nil,
            metadata: [String: String]? = nil,
            tfaEnabled: Bool? = nil,
            tfaActive: Bool? = nil,
            tfaCreatedAt: String? = nil,
            passwordUpdatedAt: String? = nil,
            preferences: Preferences? = nil,
            auth: AuthDetails? = nil,
            githubUserId: String? = nil,
            salesforceUserId: String? = nil,
            migrationStatus: String? = nil
        ) {
            self.id = id
            self.activated = activated
            self.name = name
            self.isDisabled = isDisabled
            self.email = email
            self.emailDetails = emailDetails
            self.role = role
            self.accountId = accountId
            self.openedIp = openedIp
            self.isMaster = isMaster
            self.metadata = metadata
            self.tfaEnabled = tfaEnabled
            self.tfaActive = tfaActive
            self.tfaCreatedAt = tfaCreatedAt
            self.passwordUpdatedAt = passwordUpdatedAt
            self.preferences = preferences
            self.auth = auth
            self.githubUserId = githubUserId
            self.salesforceUserId = salesforceUserId
            self.migrationStatus = migrationStatus
        }
        
        private enum CodingKeys: String, CodingKey {
            case id
            case activated
            case name
            case isDisabled = "is_disabled"
            case email
            case emailDetails = "email_details"
            case role
            case accountId = "account_id"
            case openedIp = "opened_ip"
            case isMaster = "is_master"
            case metadata
            case tfaEnabled = "tfa_enabled"
            case tfaActive = "tfa_active"
            case tfaCreatedAt = "tfa_created_at"
            case passwordUpdatedAt = "password_updated_at"
            case preferences
            case auth
            case githubUserId = "github_user_id"
            case salesforceUserId = "salesforce_user_id"
            case migrationStatus = "migration_status"
        }
    }
    
    public struct EmailDetails: Sendable, Decodable, Equatable {
        public let address: String
        public let isValid: Bool?
        public let reason: String?
        public let parts: EmailParts?
        
        public init(
            address: String,
            isValid: Bool? = nil,
            reason: String? = nil,
            parts: EmailParts? = nil
        ) {
            self.address = address
            self.isValid = isValid
            self.reason = reason
            self.parts = parts
        }
        
        private enum CodingKeys: String, CodingKey {
            case address
            case isValid = "is_valid"
            case reason
            case parts
        }
    }
    
    public struct EmailParts: Sendable, Decodable, Equatable {
        public let domain: String?
        public let localPart: String?
        public let displayName: String?
        
        public init(
            domain: String? = nil,
            localPart: String? = nil,
            displayName: String? = nil
        ) {
            self.domain = domain
            self.localPart = localPart
            self.displayName = displayName
        }
        
        private enum CodingKeys: String, CodingKey {
            case domain
            case localPart = "local_part"
            case displayName = "display_name"
        }
    }
    
    public struct Preferences: Sendable, Decodable, Equatable {
        public let timeZone: String?
        public let timeFormat: String?
        public let programmingLanguage: String?
        
        public init(
            timeZone: String? = nil,
            timeFormat: String? = nil,
            programmingLanguage: String? = nil
        ) {
            self.timeZone = timeZone
            self.timeFormat = timeFormat
            self.programmingLanguage = programmingLanguage
        }
        
        private enum CodingKeys: String, CodingKey {
            case timeZone = "time_zone"
            case timeFormat = "time_format"
            case programmingLanguage = "programming_language"
        }
    }
    
    public struct AuthDetails: Sendable, Decodable, Equatable {
        public let method: String
        public let priorMethod: String?
        public let priorDetails: [String: String]?
        
        public init(
            method: String,
            priorMethod: String? = nil,
            priorDetails: [String: String]? = nil
        ) {
            self.method = method
            self.priorMethod = priorMethod
            self.priorDetails = priorDetails
        }
        
        private enum CodingKeys: String, CodingKey {
            case method
            case priorMethod = "prior_method"
            case priorDetails = "prior_details"
        }
    }
    
    public enum Role: String, Sendable, Codable, Equatable {
        case basic = "basic"
        case billing = "billing"
        case support = "support"
        case developer = "developer"
        case admin = "admin"
    }
}

// MARK: - List
extension Mailgun.Users {
    public enum List {}
}

extension Mailgun.Users.List {
    public struct Request: Sendable, Codable, Equatable {
        public let role: Mailgun.Users.Role?
        public let limit: Int?
        public let skip: Int?
        
        public init(
            role: Mailgun.Users.Role? = nil,
            limit: Int? = nil,
            skip: Int? = nil
        ) {
            self.role = role
            self.limit = limit
            self.skip = skip
        }
    }
    
    public struct Response: Sendable, Decodable, Equatable {
        public let users: [Mailgun.Users.User]
        public let total: Int
        
        public init(
            users: [Mailgun.Users.User],
            total: Int
        ) {
            self.users = users
            self.total = total
        }
    }
}

// MARK: - Get
extension Mailgun.Users {
    public enum Get {}
}

extension Mailgun.Users.Get {
    public typealias Response = Mailgun.Users.User
}

// MARK: - Me
extension Mailgun.Users {
    public enum Me {}
}

extension Mailgun.Users.Me {
    public typealias Response = Mailgun.Users.User
}

// MARK: - Organization
extension Mailgun.Users {
    public enum Organization {}
}

extension Mailgun.Users.Organization {
    public enum Add {}
    public enum Remove {}
}

extension Mailgun.Users.Organization.Add {
    public typealias Request = Void  // No request body needed
    
    public struct Response: Sendable, Decodable, Equatable {
        public let message: String
        
        public init(message: String) {
            self.message = message
        }
    }
}

extension Mailgun.Users.Organization.Remove {
    public struct Response: Sendable, Decodable, Equatable {
        public let message: String
        
        public init(message: String) {
            self.message = message
        }
    }
}
