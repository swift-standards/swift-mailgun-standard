//
//  File.swift
//  coenttb-mailgun
//
//  Created by Coen ten Thije Boonkkamp on 24/12/2024.
//

@_exported import Mailgun_Types_Shared

extension Mailgun {
    public enum Subaccounts {}
}

extension Mailgun.Subaccounts {
    public struct Subaccount: Sendable, Codable, Equatable {
        public let id: String
        public let name: String
        public let status: Status
        public let createdAt: String?
        public let updatedAt: String?
        public let features: [String: String]?

        public init(
            id: String,
            name: String,
            status: Status,
            createdAt: String? = nil,
            updatedAt: String? = nil,
            features: [String: String]? = nil
        ) {
            self.id = id
            self.name = name
            self.status = status
            self.createdAt = createdAt
            self.updatedAt = updatedAt
            self.features = features
        }

        public enum Status: String, Sendable, Codable, Equatable {
            case disabled
            case open
            case closed
        }
        
        private enum CodingKeys: String, CodingKey {
            case id
            case name
            case status
            case createdAt = "created_at"
            case updatedAt = "updated_at"
            case features
        }
    }
}

// MARK: - Get
extension Mailgun.Subaccounts {
    public enum Get {}
}

extension Mailgun.Subaccounts.Get {
    public struct Response: Sendable, Decodable, Equatable {
        public let subaccount: Mailgun.Subaccounts.Subaccount
        
        public init(subaccount: Mailgun.Subaccounts.Subaccount) {
            self.subaccount = subaccount
        }
    }
}

// MARK: - List
extension Mailgun.Subaccounts {
    public enum List {}
}

extension Mailgun.Subaccounts.List {
    public struct Request: Sendable, Codable, Equatable {
        public let sort: Sort?
        public let filter: String?
        public let limit: Int?
        public let skip: Int?
        public let enabled: Bool?
        public let closed: Bool?
        
        public init(
            sort: Sort? = nil,
            filter: String? = nil,
            limit: Int? = nil,
            skip: Int? = nil,
            enabled: Bool? = nil,
            closed: Bool? = nil
        ) {
            self.sort = sort
            self.filter = filter
            self.limit = limit
            self.skip = skip
            self.enabled = enabled
            self.closed = closed
        }
        
        public enum Sort: String, Sendable, Codable, Equatable {
            case asc
            case desc
        }
    }
    
    public struct Response: Sendable, Decodable, Equatable {
        public let subaccounts: [Mailgun.Subaccounts.Subaccount]
        public let total: Int

        public init(subaccounts: [Mailgun.Subaccounts.Subaccount], total: Int) {
            self.subaccounts = subaccounts
            self.total = total
        }
    }
}

// MARK: - Create
extension Mailgun.Subaccounts {
    public enum Create {}
}

extension Mailgun.Subaccounts.Create {
    public struct Request: Sendable, Codable, Equatable {
        public let name: String

        public init(name: String) {
            self.name = name
        }
    }
    
    public struct Response: Sendable, Decodable, Equatable {
        public let subaccount: Mailgun.Subaccounts.Subaccount
        
        public init(subaccount: Mailgun.Subaccounts.Subaccount) {
            self.subaccount = subaccount
        }
    }
}

// MARK: - Delete
extension Mailgun.Subaccounts {
    public enum Delete {}
}

extension Mailgun.Subaccounts.Delete {
    public struct Response: Sendable, Decodable, Equatable {
        public let message: String

        public init(message: String) {
            self.message = message
        }
    }
}

// MARK: - Disable
extension Mailgun.Subaccounts {
    public enum Disable {}
}

extension Mailgun.Subaccounts.Disable {
    public struct Request: Sendable, Codable, Equatable {
        public let reason: String?
        public let note: String?
        
        public init(reason: String? = nil, note: String? = nil) {
            self.reason = reason
            self.note = note
        }
    }
    
    public struct Response: Sendable, Decodable, Equatable {
        public let subaccount: Mailgun.Subaccounts.Subaccount

        public init(subaccount: Mailgun.Subaccounts.Subaccount) {
            self.subaccount = subaccount
        }
    }
}

// MARK: - Enable
extension Mailgun.Subaccounts {
    public enum Enable {}
}

extension Mailgun.Subaccounts.Enable {
    public struct Response: Sendable, Decodable, Equatable {
        public let subaccount: Mailgun.Subaccounts.Subaccount

        public init(subaccount: Mailgun.Subaccounts.Subaccount) {
            self.subaccount = subaccount
        }
    }
}

// MARK: - CustomLimit
extension Mailgun.Subaccounts {
    public enum CustomLimit {}
}

extension Mailgun.Subaccounts.CustomLimit {
    public enum Get {}
    public enum Update {}
    public enum Delete {}
}

extension Mailgun.Subaccounts.CustomLimit.Get {
    public struct Response: Sendable, Decodable, Equatable {
        public let limit: Double
        public let current: Double
        public let period: String

        public init(limit: Double, current: Double, period: String) {
            self.limit = limit
            self.current = current
            self.period = period
        }
    }
}

extension Mailgun.Subaccounts.CustomLimit.Update {
    public struct Request: Sendable, Codable, Equatable {
        public let limit: Double

        public init(limit: Double) {
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

extension Mailgun.Subaccounts.CustomLimit.Delete {
    public struct Response: Sendable, Decodable, Equatable {
        public let success: Bool

        public init(success: Bool) {
            self.success = success
        }
    }
}

// MARK: - Features
extension Mailgun.Subaccounts {
    public enum Features {}
}

extension Mailgun.Subaccounts.Features {
    public enum Update {}
}

extension Mailgun.Subaccounts.Features.Update {
    public struct Request: Sendable, Codable, Equatable {
        public let emailPreview: FeatureOverride?
        public let inboxPlacement: FeatureOverride?
        public let sending: FeatureOverride?
        public let validations: FeatureOverride?
        public let validationsBulk: FeatureOverride?

        public init(
            emailPreview: FeatureOverride? = nil,
            inboxPlacement: FeatureOverride? = nil,
            sending: FeatureOverride? = nil,
            validations: FeatureOverride? = nil,
            validationsBulk: FeatureOverride? = nil
        ) {
            self.emailPreview = emailPreview
            self.inboxPlacement = inboxPlacement
            self.sending = sending
            self.validations = validations
            self.validationsBulk = validationsBulk
        }
        
        private enum CodingKeys: String, CodingKey {
            case emailPreview = "email_preview"
            case inboxPlacement = "inbox_placement"
            case sending
            case validations
            case validationsBulk = "validations_bulk"
        }
        
        public struct FeatureOverride: Sendable, Codable, Equatable {
            public let enabled: Bool
            
            public init(enabled: Bool) {
                self.enabled = enabled
            }
        }
    }
    
    public struct Response: Sendable, Decodable, Equatable {
        public let features: [String: String]

        public init(features: [String: String]) {
            self.features = features
        }
    }
}
