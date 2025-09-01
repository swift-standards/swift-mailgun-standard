//
//  File.swift
//  swift-mailgun
//
//  Created by Coen ten Thije Boonkkamp on 20/12/2024.
//

import EmailAddress
@_exported import Mailgun_Types_Shared

extension Mailgun {
    public enum Messages {}
}

extension Mailgun.Messages {
    public enum Send {}
}

extension Mailgun.Messages.Send {
    public struct Request: Sendable, Equatable, Codable {
        public let from: EmailAddress
        public let to: [EmailAddress]
        public let subject: String
        public let html: String?
        public let text: String?
        public let cc: [EmailAddress]?
        public let bcc: [EmailAddress]?
        public let ampHtml: String?
        public let template: String?
        public let templateVersion: String?
        public let templateText: Bool?
        public let templateVariables: String?
        public let attachments: [Mailgun.Messages.Attachment.Data]?
        public let inline: [Mailgun.Messages.Attachment.Data]?
        public let tags: [String]?
        public let dkim: Bool?
        public let secondaryDkim: String?
        public let secondaryDkimPublic: String?
        public let deliveryTime: Date?
        public let deliveryTimeOptimizePeriod: String?
        public let timeZoneLocalize: String?
        public let testMode: Bool?
        public let tracking: Mailgun.Messages.Tracking.Option?
        public let trackingClicks: Mailgun.Messages.Tracking.Option?
        public let trackingOpens: Bool?
        public let requireTls: Bool?
        public let skipVerification: Bool?
        public let sendingIp: String?
        public let sendingIpPool: String?
        public let trackingPixelLocationTop: Bool?
        public var headers: [String: String]?
        public let variables: [String: String]?
        public let recipientVariables: String?

        public enum CodingKeys: String, CodingKey {
            case from
            case to
            case subject
            case html
            case text
            case cc
            case bcc
            case ampHtml = "amp-html"
            case template
            case templateVersion = "t:version"
            case templateText = "t:text"
            case templateVariables = "t:variables"
            case attachments = "attachment"
            case inline
            case tags = "o:tag"
            case dkim = "o:dkim"
            case secondaryDkim = "o:secondary-dkim"
            case secondaryDkimPublic = "o:secondary-dkim-public"
            case deliveryTime = "o:deliverytime"
            case deliveryTimeOptimizePeriod = "o:deliverytime-optimize-period"
            case timeZoneLocalize = "o:time-zone-localize"
            case testMode = "o:testmode"
            case tracking = "o:tracking"
            case trackingClicks = "o:tracking-clicks"
            case trackingOpens = "o:tracking-opens"
            case requireTls = "o:require-tls"
            case skipVerification = "o:skip-verification"
            case sendingIp = "o:sending-ip"
            case sendingIpPool = "o:sending-ip-pool"
            case trackingPixelLocationTop = "o:tracking-pixel-location-top"
            case headers = "h"
            case variables = "v"
            case recipientVariables = "recipient-variables"
        }

        public init(
            from: EmailAddress,
            to: [EmailAddress],
            subject: String,
            html: String? = nil,
            text: String? = nil,
            cc: [EmailAddress]? = nil,
            bcc: [EmailAddress]? = nil,
            ampHtml: String? = nil,
            template: String? = nil,
            templateVersion: String? = nil,
            templateText: Bool? = nil,
            templateVariables: String? = nil,
            attachments: [Mailgun.Messages.Attachment.Data]? = nil,
            inline: [Mailgun.Messages.Attachment.Data]? = nil,
            tags: [String]? = nil,
            dkim: Bool? = nil,
            secondaryDkim: String? = nil,
            secondaryDkimPublic: String? = nil,
            deliveryTime: Date? = nil,
            deliveryTimeOptimizePeriod: String? = nil,
            timeZoneLocalize: String? = nil,
            testMode: Bool? = nil,
            tracking: Mailgun.Messages.Tracking.Option? = nil,
            trackingClicks: Mailgun.Messages.Tracking.Option? = nil,
            trackingOpens: Bool? = nil,
            requireTls: Bool? = nil,
            skipVerification: Bool? = nil,
            sendingIp: String? = nil,
            sendingIpPool: String? = nil,
            trackingPixelLocationTop: Bool? = nil,
            headers: [String: String]? = nil,
            variables: [String: String]? = nil,
            recipientVariables: String? = nil
        ) {
            self.from = from
            self.to = to
            self.subject = subject
            self.html = html
            self.text = text
            self.cc = cc
            self.bcc = bcc
            self.ampHtml = ampHtml
            self.template = template
            self.templateVersion = templateVersion
            self.templateText = templateText
            self.templateVariables = templateVariables
            self.attachments = attachments
            self.inline = inline
            self.tags = tags
            self.dkim = dkim
            self.secondaryDkim = secondaryDkim
            self.secondaryDkimPublic = secondaryDkimPublic
            self.deliveryTime = deliveryTime
            self.deliveryTimeOptimizePeriod = deliveryTimeOptimizePeriod
            self.timeZoneLocalize = timeZoneLocalize
            self.testMode = testMode
            self.tracking = tracking
            self.trackingClicks = trackingClicks
            self.trackingOpens = trackingOpens
            self.requireTls = requireTls
            self.skipVerification = skipVerification
            self.sendingIp = sendingIp
            self.sendingIpPool = sendingIpPool
            self.trackingPixelLocationTop = trackingPixelLocationTop
            self.headers = headers
            self.variables = variables
            self.recipientVariables = recipientVariables
        }
    }

    public struct Response: Sendable, Decodable, Equatable {
        public let id: String
        public let message: String

        public init(id: String, message: String) {
            self.id = id
            self.message = message
        }
    }

    public enum Mime {
        public struct Request: Sendable, Equatable, Codable {
            public let to: [EmailAddress]
            public let message: Foundation.Data
            public let template: String?
            public let templateVersion: String?
            public let templateText: Bool?
            public let templateVariables: String?
            public let tags: [String]?
            public let dkim: Bool?
            public let secondaryDkim: String?
            public let secondaryDkimPublic: String?
            public let deliveryTime: Date?
            public let deliveryTimeOptimizePeriod: String?
            public let timeZoneLocalize: String?
            public let testMode: Bool?
            public let tracking: Mailgun.Messages.Tracking.Option?
            public let trackingClicks: Mailgun.Messages.Tracking.Option?
            public let trackingOpens: Bool?
            public let requireTls: Bool?
            public let skipVerification: Bool?
            public let sendingIp: String?
            public let sendingIpPool: String?
            public let trackingPixelLocationTop: Bool?
            public let headers: [String: String]?
            public let variables: [String: String]?
            public let recipientVariables: String?

            public enum CodingKeys: String, CodingKey {
                case to
                case message
                case template
                case templateVersion = "t:version"
                case templateText = "t:text"
                case templateVariables = "t:variables"
                case tags = "o:tag"
                case dkim = "o:dkim"
                case secondaryDkim = "o:secondary-dkim"
                case secondaryDkimPublic = "o:secondary-dkim-public"
                case deliveryTime = "o:deliverytime"
                case deliveryTimeOptimizePeriod = "o:deliverytime-optimize-period"
                case timeZoneLocalize = "o:time-zone-localize"
                case testMode = "o:testmode"
                case tracking = "o:tracking"
                case trackingClicks = "o:tracking-clicks"
                case trackingOpens = "o:tracking-opens"
                case requireTls = "o:require-tls"
                case skipVerification = "o:skip-verification"
                case sendingIp = "o:sending-ip"
                case sendingIpPool = "o:sending-ip-pool"
                case trackingPixelLocationTop = "o:tracking-pixel-location-top"
                case headers = "h"
                case variables = "v"
                case recipientVariables = "recipient-variables"
            }

            public init(
                to: [EmailAddress],
                message: Foundation.Data,
                template: String? = nil,
                templateVersion: String? = nil,
                templateText: Bool? = nil,
                templateVariables: String? = nil,
                tags: [String]? = nil,
                dkim: Bool? = nil,
                secondaryDkim: String? = nil,
                secondaryDkimPublic: String? = nil,
                deliveryTime: Date? = nil,
                deliveryTimeOptimizePeriod: String? = nil,
                timeZoneLocalize: String? = nil,
                testMode: Bool? = nil,
                tracking: Mailgun.Messages.Tracking.Option? = nil,
                trackingClicks: Mailgun.Messages.Tracking.Option? = nil,
                trackingOpens: Bool? = nil,
                requireTls: Bool? = nil,
                skipVerification: Bool? = nil,
                sendingIp: String? = nil,
                sendingIpPool: String? = nil,
                trackingPixelLocationTop: Bool? = nil,
                headers: [String: String]? = nil,
                variables: [String: String]? = nil,
                recipientVariables: String? = nil
            ) {
                self.to = to
                self.message = message
                self.template = template
                self.templateVersion = templateVersion
                self.templateText = templateText
                self.templateVariables = templateVariables
                self.tags = tags
                self.dkim = dkim
                self.secondaryDkim = secondaryDkim
                self.secondaryDkimPublic = secondaryDkimPublic
                self.deliveryTime = deliveryTime
                self.deliveryTimeOptimizePeriod = deliveryTimeOptimizePeriod
                self.timeZoneLocalize = timeZoneLocalize
                self.testMode = testMode
                self.tracking = tracking
                self.trackingClicks = trackingClicks
                self.trackingOpens = trackingOpens
                self.requireTls = requireTls
                self.skipVerification = skipVerification
                self.sendingIp = sendingIp
                self.sendingIpPool = sendingIpPool
                self.trackingPixelLocationTop = trackingPixelLocationTop
                self.headers = headers
                self.variables = variables
                self.recipientVariables = recipientVariables
            }
        }
    }
}

extension Mailgun.Messages {
    public enum Attachment {
        public struct Data: Sendable, Codable, Equatable {
            public let data: Foundation.Data
            public let filename: String
            public let contentType: String

            public init(data: Foundation.Data, filename: String, contentType: String) {
                self.data = data
                self.filename = filename
                self.contentType = contentType
            }
        }
    }
}

extension Mailgun.Messages {
    public enum Tracking {
        public enum Option: String, Sendable, Codable, Equatable {
            case yes
            case no
            case htmlOnly = "htmlonly"
        }
    }
}

extension Mailgun.Messages.Tracking.Option: ExpressibleByBooleanLiteral {
    public init(booleanLiteral value: Bool) {
        self = value ? .yes : .no
    }
}

extension Mailgun.Messages {
    public struct StoredMessage: Sendable, Decodable, Equatable {
        public let contentTransferEncoding: String
        public let contentType: String
        public let from: EmailAddress
        public let messageId: String
        public let mimeVersion: String
        public let subject: String
        public let to: EmailAddress
        public let tags: [String]
        public let sender: EmailAddress
        public let recipients: [EmailAddress]
        public let bodyHtml: String?
        public let bodyPlain: String?
        public let strippedHtml: String?
        public let strippedText: String?
        public let strippedSignature: String?
        public let messageHeaders: [[String]]
        public let templateName: String?
        public let templateVariables: String?

        public init(
            contentTransferEncoding: String,
            contentType: String,
            from: EmailAddress,
            messageId: String,
            mimeVersion: String,
            subject: String,
            to: EmailAddress,
            tags: [String],
            sender: EmailAddress,
            recipients: [EmailAddress],
            bodyHtml: String?,
            bodyPlain: String?,
            strippedHtml: String?,
            strippedText: String?,
            strippedSignature: String?,
            messageHeaders: [[String]],
            templateName: String?,
            templateVariables: String?
        ) {
            self.contentTransferEncoding = contentTransferEncoding
            self.contentType = contentType
            self.from = from
            self.messageId = messageId
            self.mimeVersion = mimeVersion
            self.subject = subject
            self.to = to
            self.tags = tags
            self.sender = sender
            self.recipients = recipients
            self.bodyHtml = bodyHtml
            self.bodyPlain = bodyPlain
            self.strippedHtml = strippedHtml
            self.strippedText = strippedText
            self.strippedSignature = strippedSignature
            self.messageHeaders = messageHeaders
            self.templateName = templateName
            self.templateVariables = templateVariables
        }
    }
}

extension Mailgun.Messages {
    public enum Queue {
        public struct Status: Sendable, Decodable, Equatable {
            public let regular: QueueInfo
            public let scheduled: QueueInfo

            public init(regular: QueueInfo, scheduled: QueueInfo) {
                self.regular = regular
                self.scheduled = scheduled
            }

            public struct QueueInfo: Sendable, Decodable, Equatable {
                public let isDisabled: Bool
                public let disabled: DisabledInfo?

                public init(isDisabled: Bool, disabled: DisabledInfo?) {
                    self.isDisabled = isDisabled
                    self.disabled = disabled
                }
            }

            public struct DisabledInfo: Sendable, Decodable, Equatable {
                public let until: Date
                public let reason: String

                public init(until: Date, reason: String) {
                    self.until = until
                    self.reason = reason
                }
            }
        }
    }
}

extension Mailgun.Messages {
    public enum Delete {
        public struct Response: Sendable, Decodable, Equatable {
            public let message: String

            public init(message: String) {
                self.message = message
            }
        }
    }
}
