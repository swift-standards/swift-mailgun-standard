//
//  File.swift
//  swift-mailgun
//
//  Created by Coen ten Thije Boonkkamp on 24/12/2024.
//

@_exported import Mailgun_Types_Shared

extension Mailgun.Domains.Domains {
    public enum Tracking {}
}

// MARK: - Core Types

extension Mailgun.Domains.Domains.Tracking {
    public struct Settings: Sendable, Codable, Equatable {
        public let click: ClickSettings
        public let open: OpenSettings
        public let unsubscribe: UnsubscribeSettings

        public init(
            click: ClickSettings,
            open: OpenSettings,
            unsubscribe: UnsubscribeSettings
        ) {
            self.click = click
            self.open = open
            self.unsubscribe = unsubscribe
        }
    }

    public struct ClickSettings: Sendable, Codable, Equatable {
        public let active: Bool

        public init(active: Bool) {
            self.active = active
        }
    }

    public struct OpenSettings: Sendable, Codable, Equatable {
        public let active: Bool

        public init(active: Bool) {
            self.active = active
        }
    }

    public struct UnsubscribeSettings: Sendable, Codable, Equatable {
        public let active: Bool
        public let htmlFooter: String?
        public let textFooter: String?

        public init(
            active: Bool,
            htmlFooter: String? = nil,
            textFooter: String? = nil
        ) {
            self.active = active
            self.htmlFooter = htmlFooter
            self.textFooter = textFooter
        }

        private enum CodingKeys: String, CodingKey {
            case active
            case htmlFooter = "html_footer"
            case textFooter = "text_footer"
        }
    }
}

// MARK: - Get Tracking Settings

extension Mailgun.Domains.Domains.Tracking {
    public enum Get {}
}

extension Mailgun.Domains.Domains.Tracking.Get {
    public struct Response: Sendable, Codable, Equatable {
        public let tracking: Mailgun.Domains.Domains.Tracking.Settings

        public init(tracking: Mailgun.Domains.Domains.Tracking.Settings) {
            self.tracking = tracking
        }
    }
}

// MARK: - Update Click Tracking

extension Mailgun.Domains.Domains.Tracking {
    public enum UpdateClick {}
}

extension Mailgun.Domains.Domains.Tracking.UpdateClick {
    public struct Request: Sendable, Codable, Equatable {
        public let active: Bool

        public init(active: Bool) {
            self.active = active
        }
    }

    public struct Response: Sendable, Codable, Equatable {
        public let message: String
        public let click: Mailgun.Domains.Domains.Tracking.ClickSettings

        public init(
            message: String,
            click: Mailgun.Domains.Domains.Tracking.ClickSettings
        ) {
            self.message = message
            self.click = click
        }
    }
}

// MARK: - Update Open Tracking

extension Mailgun.Domains.Domains.Tracking {
    public enum UpdateOpen {}
}

extension Mailgun.Domains.Domains.Tracking.UpdateOpen {
    public struct Request: Sendable, Codable, Equatable {
        public let active: Bool

        public init(active: Bool) {
            self.active = active
        }
    }

    public struct Response: Sendable, Codable, Equatable {
        public let message: String
        public let open: Mailgun.Domains.Domains.Tracking.OpenSettings

        public init(
            message: String,
            open: Mailgun.Domains.Domains.Tracking.OpenSettings
        ) {
            self.message = message
            self.open = open
        }
    }
}

// MARK: - Update Unsubscribe Tracking

extension Mailgun.Domains.Domains.Tracking {
    public enum UpdateUnsubscribe {}
}

extension Mailgun.Domains.Domains.Tracking.UpdateUnsubscribe {
    public struct Request: Sendable, Codable, Equatable {
        public let active: Bool
        public let htmlFooter: String?
        public let textFooter: String?

        public init(
            active: Bool,
            htmlFooter: String? = nil,
            textFooter: String? = nil
        ) {
            self.active = active
            self.htmlFooter = htmlFooter
            self.textFooter = textFooter
        }

        private enum CodingKeys: String, CodingKey {
            case active
            case htmlFooter = "html_footer"
            case textFooter = "text_footer"
        }
    }

    public struct Response: Sendable, Codable, Equatable {
        public let message: String
        public let unsubscribe: Mailgun.Domains.Domains.Tracking.UnsubscribeSettings

        public init(
            message: String,
            unsubscribe: Mailgun.Domains.Domains.Tracking.UnsubscribeSettings
        ) {
            self.message = message
            self.unsubscribe = unsubscribe
        }
    }
}
