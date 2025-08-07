//
//  File.swift
//  coenttb-mailgun
//
//  Created by Coen ten Thije Boonkkamp on 24/12/2024.
//

@_exported import Mailgun_Types_Shared

extension Mailgun {
    public enum Webhooks {}
}

// MARK: - Core Types

extension Mailgun.Webhooks {
    public struct Webhook: Sendable, Codable, Equatable {
        public let urls: [String]

        public init(urls: [String]) {
            self.urls = urls
        }
    }
    
    public enum WebhookType: String, Sendable, Codable, Equatable, CaseIterable {
        case accepted = "accepted"
        case delivered = "delivered"
        case opened = "opened"
        case clicked = "clicked"
        case unsubscribed = "unsubscribed"
        case complained = "complained"
        case permanentFail = "permanent_fail"
        case temporaryFail = "temporary_fail"
    }
}

// MARK: - List

extension Mailgun.Webhooks {
    public enum List {}
}

extension Mailgun.Webhooks.List {
    public struct Response: Sendable, Codable, Equatable {
        public let webhooks: Webhooks
        
        public init(webhooks: Webhooks) {
            self.webhooks = webhooks
        }
    }
    
    public struct Webhooks: Sendable, Codable, Equatable {
        public let accepted: Mailgun.Webhooks.Webhook?
        public let delivered: Mailgun.Webhooks.Webhook?
        public let opened: Mailgun.Webhooks.Webhook?
        public let clicked: Mailgun.Webhooks.Webhook?
        public let unsubscribed: Mailgun.Webhooks.Webhook?
        public let complained: Mailgun.Webhooks.Webhook?
        public let temporary_fail: Mailgun.Webhooks.Webhook?
        public let permanent_fail: Mailgun.Webhooks.Webhook?
        
        public init(
            accepted: Mailgun.Webhooks.Webhook? = nil,
            delivered: Mailgun.Webhooks.Webhook? = nil,
            opened: Mailgun.Webhooks.Webhook? = nil,
            clicked: Mailgun.Webhooks.Webhook? = nil,
            unsubscribed: Mailgun.Webhooks.Webhook? = nil,
            complained: Mailgun.Webhooks.Webhook? = nil,
            temporary_fail: Mailgun.Webhooks.Webhook? = nil,
            permanent_fail: Mailgun.Webhooks.Webhook? = nil
        ) {
            self.accepted = accepted
            self.delivered = delivered
            self.opened = opened
            self.clicked = clicked
            self.unsubscribed = unsubscribed
            self.complained = complained
            self.temporary_fail = temporary_fail
            self.permanent_fail = permanent_fail
        }
        
        public subscript(_ type: Mailgun.Webhooks.WebhookType) -> Mailgun.Webhooks.Webhook? {
            switch type {
            case .accepted: return accepted
            case .delivered: return delivered
            case .opened: return opened
            case .clicked: return clicked
            case .unsubscribed: return unsubscribed
            case .complained: return complained
            case .temporaryFail: return temporary_fail
            case .permanentFail: return permanent_fail
            }
        }
    }
}

// MARK: - Get

extension Mailgun.Webhooks {
    public enum Get {}
}

extension Mailgun.Webhooks.Get {
    public struct Response: Sendable, Codable, Equatable {
        public let webhook: Mailgun.Webhooks.Webhook
        
        public init(webhook: Mailgun.Webhooks.Webhook) {
            self.webhook = webhook
        }
    }
}

// MARK: - Create

extension Mailgun.Webhooks {
    public enum Create {}
}

extension Mailgun.Webhooks.Create {
    public struct Request: Sendable, Codable, Equatable {
        public let id: Mailgun.Webhooks.WebhookType
        public let url: [String]
        
        public init(id: Mailgun.Webhooks.WebhookType, url: [String]) {
            self.id = id
            self.url = url
        }
        
        public init(id: Mailgun.Webhooks.WebhookType, url: String) {
            self.id = id
            self.url = [url]
        }
    }
    
    public struct Response: Sendable, Codable, Equatable {
        public let message: String
        public let webhook: Mailgun.Webhooks.Webhook
        
        public init(message: String, webhook: Mailgun.Webhooks.Webhook) {
            self.message = message
            self.webhook = webhook
        }
    }
}

// MARK: - Update

extension Mailgun.Webhooks {
    public enum Update {}
}

extension Mailgun.Webhooks.Update {
    public struct Request: Sendable, Codable, Equatable {
        public let url: [String]
        
        public init(url: [String]) {
            self.url = url
        }
        
        public init(url: String) {
            self.url = [url]
        }
    }
    
    public struct Response: Sendable, Codable, Equatable {
        public let message: String
        public let webhook: Mailgun.Webhooks.Webhook
        
        public init(message: String, webhook: Mailgun.Webhooks.Webhook) {
            self.message = message
            self.webhook = webhook
        }
    }
}

// MARK: - Delete

extension Mailgun.Webhooks {
    public enum Delete {}
}

extension Mailgun.Webhooks.Delete {
    public struct Response: Sendable, Codable, Equatable {
        public let message: String
        public let webhook: Mailgun.Webhooks.Webhook
        
        public init(message: String, webhook: Mailgun.Webhooks.Webhook) {
            self.message = message
            self.webhook = webhook
        }
    }
}
