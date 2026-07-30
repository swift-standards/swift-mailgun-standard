//
//  File.swift
//  swift-mailgun
//
//  Created by Coen ten Thije Boonkkamp on 26/12/2024.
//

import EmailAddress_Standard
import RFC_3986
import Time_Primitive

extension Mailgun.Reporting.Events {
    public enum List {}
}

extension Mailgun.Reporting.Events.List {
    public struct Response: Sendable, Decodable, Equatable {
        public let items: [Mailgun.Reporting.Events.Event]
        public let paging: Paging

        public struct Paging: Sendable, Decodable, Equatable {
            public let next: RFC_3986.URI?
            public let previous: RFC_3986.URI?
            public let first: RFC_3986.URI?
            public let last: RFC_3986.URI?
        }
    }
}

extension Mailgun.Reporting.Events.List {
    public struct Query: Sendable, Equatable {
        public let begin: Time.Epoch?
        public let end: Time.Epoch?
        public let ascending: Mailgun.Reporting.Events.List.Query.Ascending?
        public let limit: Int?
        public let event: Mailgun.Reporting.Events.Event.Variant?
        public let list: String?
        public let attachment: String?
        public let from: EmailAddress?
        public let messageId: String?
        public let subject: String?
        public let to: EmailAddress?
        public let size: Int?
        public let recipient: EmailAddress?
        public let recipients: [EmailAddress]?
        public let tags: [String]?
        public let severity: Severity?

        public init(
            begin: Time.Epoch? = nil,
            end: Time.Epoch? = nil,
            ascending: Mailgun.Reporting.Events.List.Query.Ascending? = nil,
            limit: Int? = nil,
            event: Mailgun.Reporting.Events.Event.Variant? = nil,
            list: String? = nil,
            attachment: String? = nil,
            from: EmailAddress? = nil,
            messageId: String? = nil,
            subject: String? = nil,
            to: EmailAddress? = nil,
            size: Int? = nil,
            recipient: EmailAddress? = nil,
            recipients: [EmailAddress]? = nil,
            tags: [String]? = nil,
            severity: Severity? = nil
        ) {
            self.begin = begin
            self.end = end
            self.ascending = ascending
            self.limit = limit
            self.event = event
            self.list = list
            self.attachment = attachment
            self.from = from
            self.messageId = messageId
            self.subject = subject
            self.to = to
            self.size = size
            self.recipient = recipient
            self.recipients = recipients
            self.tags = tags
            self.severity = severity
        }

        public enum Severity: String, Sendable, Codable, Equatable {
            case temporary
            case permanent
        }

        public enum Ascending: String, Sendable, Codable, Equatable {
            case yes
            case no

        }
    }
}

extension Mailgun.Reporting.Events.List.Query.Ascending: ExpressibleByBooleanLiteral {
    public init(booleanLiteral value: BooleanLiteralType) {
        self = value ? .yes : .no
    }
}
