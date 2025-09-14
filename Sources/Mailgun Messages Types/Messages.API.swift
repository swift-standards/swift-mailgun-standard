//
//  File.swift
//  swift-mailgun
//
//  Created by Coen ten Thije Boonkkamp on 20/12/2024.
//

import Foundation
import Mailgun_Types_Shared
import URLFormCoding
import URLMultipartFormCoding
import URLRouting

extension Mailgun.Messages {
    @CasePathable
    @dynamicMemberLookup
    public enum API: Equatable, Sendable {
        case send(domain: Domain, request: Mailgun.Messages.Send.Request)
        case sendMime(domain: Domain, request: Mailgun.Messages.Send.Mime.Request)
        case retrieve(domain: Domain, storageKey: String)
        case queueStatus(domain: Domain)
        case deleteScheduled(domain: Domain)
    }
}

extension Mailgun.Messages.API {
    public struct Router: ParserPrinter, Sendable {
        public init() {}

        public var body: some URLRouting.Router<Mailgun.Messages.API> {
            OneOf {
                URLRouting.Route(.case(Mailgun.Messages.API.send)) {
                    let sendMultipartConversion = Mailgun.Messages.SendMultipartConversion()
                    Headers {
                        Field.contentType { sendMultipartConversion.contentType }
                    }
                    Method.post
                    Path { "v3" }
                    Path { Parse(.string.representing(Domain.self)) }
                    Path.messages
                    Body(sendMultipartConversion)
                }

                URLRouting.Route(.case(Mailgun.Messages.API.sendMime)) {
                    let mimeMultipartConversion = Mailgun.Messages.MimeMultipartConversion()
                    Headers {
                        Field.contentType { mimeMultipartConversion.contentType }
                    }
                    Method.post
                    Path { "v3" }
                    Path { Parse(.string.representing(Domain.self)) }
                    Path { "messages.mime" }
                    Body(mimeMultipartConversion)
                }

                URLRouting.Route(.case(Mailgun.Messages.API.retrieve)) {
                    Method.get
                    Path { "v3" }
                    Path.domains
                    Path { Parse(.string.representing(Domain.self)) }
                    Path.messages
                    Path { Parse(.string) }
                }

                URLRouting.Route(.case(Mailgun.Messages.API.queueStatus)) {
                    Method.get
                    Path { "v3" }
                    Path.domains
                    Path { Parse(.string.representing(Domain.self)) }
                    Path { "sending_queues" }
                }

                URLRouting.Route(.case(Mailgun.Messages.API.deleteScheduled)) {
                    Method.delete
                    Path { "v3" }
                    Path { Parse(.string.representing(Domain.self)) }
                    Path { "envelopes" }
                }
            }
        }
    }
}

extension Path<PathBuilder.Component<String>> {
    public static let messages = Path {
        "messages"
    }

    public static let domains = Path {
        "domains"
    }
}

extension Mailgun.Messages {
    struct SendMultipartConversion: URLRouting.Conversion {
        public let boundary = "Boundary-\(UUID().uuidString)"

        public init() {}

        public var contentType: String {
            "multipart/form-data; boundary=\(boundary)"
        }

        public func apply(_ input: Foundation.Data) throws -> Mailgun.Messages.Send.Request {
            fatalError("SendMultipartConversion.apply not implemented - only used for sending")
        }

        public func unapply(_ request: Mailgun.Messages.Send.Request) throws -> Foundation.Data {
            var body = Foundation.Data()

            func appendBoundary() {
                body.append("--\(boundary)\r\n".data(using: .utf8)!)
            }

            func appendClosingBoundary() {
                body.append("--\(boundary)--\r\n".data(using: .utf8)!)
            }

            func appendField(name: String, value: String) {
                appendBoundary()
                body.append("Content-Disposition: form-data; name=\"\(name)\"\r\n\r\n".data(using: .utf8)!)
                body.append("\(value)\r\n".data(using: .utf8)!)
            }

            func appendFileField(name: String, filename: String, contentType: String, data: Foundation.Data) {
                appendBoundary()
                body.append("Content-Disposition: form-data; name=\"\(name)\"; filename=\"\(filename)\"\r\n".data(using: .utf8)!)
                body.append("Content-Type: \(contentType)\r\n\r\n".data(using: .utf8)!)
                body.append(data)
                body.append("\r\n".data(using: .utf8)!)
            }

            // Add required fields
            appendField(name: Mailgun.Messages.Send.Request.CodingKeys.from.rawValue, value: request.from.rawValue)
            for recipient in request.to {
                appendField(name: Mailgun.Messages.Send.Request.CodingKeys.to.rawValue, value: recipient.rawValue)
            }
            appendField(name: Mailgun.Messages.Send.Request.CodingKeys.subject.rawValue, value: request.subject)

            // Add optional text/html content
            if let html = request.html {
                appendField(name: Mailgun.Messages.Send.Request.CodingKeys.html.rawValue, value: html)
            }
            if let text = request.text {
                appendField(name: Mailgun.Messages.Send.Request.CodingKeys.text.rawValue, value: text)
            }

            // Add CC/BCC
            if let cc = request.cc {
                for ccRecipient in cc {
                    appendField(name: Mailgun.Messages.Send.Request.CodingKeys.cc.rawValue, value: ccRecipient.rawValue)
                }
            }
            if let bcc = request.bcc {
                for bccRecipient in bcc {
                    appendField(name: Mailgun.Messages.Send.Request.CodingKeys.bcc.rawValue, value: bccRecipient.rawValue)
                }
            }

            // Add AMP HTML
            if let ampHtml = request.ampHtml {
                appendField(name: Mailgun.Messages.Send.Request.CodingKeys.ampHtml.rawValue, value: ampHtml)
            }

            // Add template fields
            if let template = request.template {
                appendField(name: Mailgun.Messages.Send.Request.CodingKeys.template.rawValue, value: template)
            }
            if let templateVersion = request.templateVersion {
                appendField(name: Mailgun.Messages.Send.Request.CodingKeys.templateVersion.rawValue, value: templateVersion)
            }
            if let templateText = request.templateText {
                appendField(name: Mailgun.Messages.Send.Request.CodingKeys.templateText.rawValue, value: templateText ? "yes" : "no")
            }
            if let templateVariables = request.templateVariables {
                appendField(name: Mailgun.Messages.Send.Request.CodingKeys.templateVariables.rawValue, value: templateVariables)
            }

            // Add attachments
            if let attachments = request.attachments {
                for attachment in attachments {
                    appendFileField(
                        name: Mailgun.Messages.Send.Request.CodingKeys.attachments.rawValue,
                        filename: attachment.filename,
                        contentType: attachment.contentType,
                        data: attachment.data
                    )
                }
            }

            // Add inline attachments
            if let inline = request.inline {
                for inlineAttachment in inline {
                    appendFileField(
                        name: Mailgun.Messages.Send.Request.CodingKeys.inline.rawValue,
                        filename: inlineAttachment.filename,
                        contentType: inlineAttachment.contentType,
                        data: inlineAttachment.data
                    )
                }
            }

            // Add tags
            if let tags = request.tags {
                for tag in tags {
                    appendField(name: Mailgun.Messages.Send.Request.CodingKeys.tags.rawValue, value: tag)
                }
            }

            // Add DKIM settings
            if let dkim = request.dkim {
                appendField(name: Mailgun.Messages.Send.Request.CodingKeys.dkim.rawValue, value: dkim ? "yes" : "no")
            }
            if let secondaryDkim = request.secondaryDkim {
                appendField(name: Mailgun.Messages.Send.Request.CodingKeys.secondaryDkim.rawValue, value: secondaryDkim)
            }
            if let secondaryDkimPublic = request.secondaryDkimPublic {
                appendField(name: Mailgun.Messages.Send.Request.CodingKeys.secondaryDkimPublic.rawValue, value: secondaryDkimPublic)
            }

            // Add delivery time
            if let deliveryTime = request.deliveryTime {
                let formatter = DateFormatter()
                formatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss zzz"
                formatter.locale = Locale(identifier: "en_US_POSIX")
                appendField(name: Mailgun.Messages.Send.Request.CodingKeys.deliveryTime.rawValue, value: formatter.string(from: deliveryTime))
            }
            if let deliveryTimeOptimizePeriod = request.deliveryTimeOptimizePeriod {
                appendField(name: Mailgun.Messages.Send.Request.CodingKeys.deliveryTimeOptimizePeriod.rawValue, value: deliveryTimeOptimizePeriod)
            }
            if let timeZoneLocalize = request.timeZoneLocalize {
                appendField(name: Mailgun.Messages.Send.Request.CodingKeys.timeZoneLocalize.rawValue, value: timeZoneLocalize)
            }

            // Add test mode
            if let testMode = request.testMode {
                appendField(name: Mailgun.Messages.Send.Request.CodingKeys.testMode.rawValue, value: testMode ? "yes" : "no")
            }

            // Add tracking options
            if let tracking = request.tracking {
                appendField(name: Mailgun.Messages.Send.Request.CodingKeys.tracking.rawValue, value: tracking.rawValue)
            }
            if let trackingClicks = request.trackingClicks {
                appendField(name: Mailgun.Messages.Send.Request.CodingKeys.trackingClicks.rawValue, value: trackingClicks.rawValue)
            }
            if let trackingOpens = request.trackingOpens {
                appendField(name: Mailgun.Messages.Send.Request.CodingKeys.trackingOpens.rawValue, value: trackingOpens ? "yes" : "no")
            }

            // Add TLS settings
            if let requireTls = request.requireTls {
                appendField(name: Mailgun.Messages.Send.Request.CodingKeys.requireTls.rawValue, value: requireTls ? "yes" : "no")
            }
            if let skipVerification = request.skipVerification {
                appendField(name: Mailgun.Messages.Send.Request.CodingKeys.skipVerification.rawValue, value: skipVerification ? "yes" : "no")
            }

            // Add sending IP settings
            if let sendingIp = request.sendingIp {
                appendField(name: Mailgun.Messages.Send.Request.CodingKeys.sendingIp.rawValue, value: sendingIp)
            }
            if let sendingIpPool = request.sendingIpPool {
                appendField(name: Mailgun.Messages.Send.Request.CodingKeys.sendingIpPool.rawValue, value: sendingIpPool)
            }

            // Add tracking pixel location
            if let trackingPixelLocationTop = request.trackingPixelLocationTop {
                appendField(name: Mailgun.Messages.Send.Request.CodingKeys.trackingPixelLocationTop.rawValue, value: trackingPixelLocationTop ? "yes" : "no")
            }

            // Add custom headers
            if let headers = request.headers {
                let headerPrefix = Mailgun.Messages.Send.Request.CodingKeys.headers.rawValue
                for (key, value) in headers {
                    appendField(name: "\(headerPrefix):\(key)", value: value)
                }
            }

            // Add custom variables
            if let variables = request.variables {
                let variablePrefix = Mailgun.Messages.Send.Request.CodingKeys.variables.rawValue
                for (key, value) in variables {
                    appendField(name: "\(variablePrefix):\(key)", value: value)
                }
            }

            // Add recipient variables
            if let recipientVariables = request.recipientVariables {
                appendField(name: Mailgun.Messages.Send.Request.CodingKeys.recipientVariables.rawValue, value: recipientVariables)
            }

            appendClosingBoundary()
            return body
        }
    }

    struct MimeMultipartConversion: URLRouting.Conversion {
        public let boundary = "Boundary-\(UUID().uuidString)"

        public init() {}

        public var contentType: String {
            "multipart/form-data; boundary=\(boundary)"
        }

        public func apply(_ input: Foundation.Data) throws -> Mailgun.Messages.Send.Mime.Request {
            fatalError("MimeMultipartConversion.apply not implemented - only used for sending")
        }

        public func unapply(_ request: Mailgun.Messages.Send.Mime.Request) throws -> Foundation.Data {
            var body = Foundation.Data()

            func appendBoundary() {
                body.append("--\(boundary)\r\n".data(using: .utf8)!)
            }

            func appendClosingBoundary() {
                body.append("--\(boundary)--\r\n".data(using: .utf8)!)
            }

            func appendField(name: String, value: String) {
                appendBoundary()
                body.append("Content-Disposition: form-data; name=\"\(name)\"\r\n\r\n".data(using: .utf8)!)
                body.append("\(value)\r\n".data(using: .utf8)!)
            }

            func appendFileField(name: String, filename: String, data: Foundation.Data) {
                appendBoundary()
                body.append("Content-Disposition: form-data; name=\"\(name)\"; filename=\"\(filename)\"\r\n".data(using: .utf8)!)
                body.append("Content-Type: application/octet-stream\r\n\r\n".data(using: .utf8)!)
                body.append(data)
                body.append("\r\n".data(using: .utf8)!)
            }

            // Add recipients
            for recipient in request.to {
                appendField(name: Mailgun.Messages.Send.Mime.Request.CodingKeys.to.rawValue, value: recipient.rawValue)
            }

            // Add message as file upload
            appendFileField(name: Mailgun.Messages.Send.Mime.Request.CodingKeys.message.rawValue, filename: "message", data: request.message)

            // Add optional fields
            if let template = request.template {
                appendField(name: Mailgun.Messages.Send.Mime.Request.CodingKeys.template.rawValue, value: template)
            }
            if let templateVersion = request.templateVersion {
                appendField(name: Mailgun.Messages.Send.Mime.Request.CodingKeys.templateVersion.rawValue, value: templateVersion)
            }
            if let templateText = request.templateText {
                appendField(name: Mailgun.Messages.Send.Mime.Request.CodingKeys.templateText.rawValue, value: templateText ? "yes" : "no")
            }
            if let templateVariables = request.templateVariables {
                appendField(name: Mailgun.Messages.Send.Mime.Request.CodingKeys.templateVariables.rawValue, value: templateVariables)
            }
            if let tags = request.tags {
                for tag in tags {
                    appendField(name: Mailgun.Messages.Send.Mime.Request.CodingKeys.tags.rawValue, value: tag)
                }
            }
            if let dkim = request.dkim {
                appendField(name: Mailgun.Messages.Send.Mime.Request.CodingKeys.dkim.rawValue, value: dkim ? "yes" : "no")
            }
            if let secondaryDkim = request.secondaryDkim {
                appendField(name: Mailgun.Messages.Send.Mime.Request.CodingKeys.secondaryDkim.rawValue, value: secondaryDkim)
            }
            if let secondaryDkimPublic = request.secondaryDkimPublic {
                appendField(name: Mailgun.Messages.Send.Mime.Request.CodingKeys.secondaryDkimPublic.rawValue, value: secondaryDkimPublic)
            }
            if let deliveryTime = request.deliveryTime {
                let formatter = DateFormatter()
                formatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss zzz"
                formatter.locale = Locale(identifier: "en_US_POSIX")
                appendField(name: Mailgun.Messages.Send.Mime.Request.CodingKeys.deliveryTime.rawValue, value: formatter.string(from: deliveryTime))
            }
            if let deliveryTimeOptimizePeriod = request.deliveryTimeOptimizePeriod {
                appendField(name: Mailgun.Messages.Send.Mime.Request.CodingKeys.deliveryTimeOptimizePeriod.rawValue, value: deliveryTimeOptimizePeriod)
            }
            if let timeZoneLocalize = request.timeZoneLocalize {
                appendField(name: Mailgun.Messages.Send.Mime.Request.CodingKeys.timeZoneLocalize.rawValue, value: timeZoneLocalize)
            }
            if let testMode = request.testMode {
                appendField(name: Mailgun.Messages.Send.Mime.Request.CodingKeys.testMode.rawValue, value: testMode ? "yes" : "no")
            }
            if let tracking = request.tracking {
                appendField(name: Mailgun.Messages.Send.Mime.Request.CodingKeys.tracking.rawValue, value: tracking.rawValue)
            }
            if let trackingClicks = request.trackingClicks {
                appendField(name: Mailgun.Messages.Send.Mime.Request.CodingKeys.trackingClicks.rawValue, value: trackingClicks.rawValue)
            }
            if let trackingOpens = request.trackingOpens {
                appendField(name: Mailgun.Messages.Send.Mime.Request.CodingKeys.trackingOpens.rawValue, value: trackingOpens ? "yes" : "no")
            }
            if let requireTls = request.requireTls {
                appendField(name: Mailgun.Messages.Send.Mime.Request.CodingKeys.requireTls.rawValue, value: requireTls ? "yes" : "no")
            }
            if let skipVerification = request.skipVerification {
                appendField(name: Mailgun.Messages.Send.Mime.Request.CodingKeys.skipVerification.rawValue, value: skipVerification ? "yes" : "no")
            }
            if let sendingIp = request.sendingIp {
                appendField(name: Mailgun.Messages.Send.Mime.Request.CodingKeys.sendingIp.rawValue, value: sendingIp)
            }
            if let sendingIpPool = request.sendingIpPool {
                appendField(name: Mailgun.Messages.Send.Mime.Request.CodingKeys.sendingIpPool.rawValue, value: sendingIpPool)
            }
            if let trackingPixelLocationTop = request.trackingPixelLocationTop {
                appendField(name: Mailgun.Messages.Send.Mime.Request.CodingKeys.trackingPixelLocationTop.rawValue, value: trackingPixelLocationTop ? "yes" : "no")
            }
            if let headers = request.headers {
                let headerPrefix = Mailgun.Messages.Send.Mime.Request.CodingKeys.headers.rawValue
                for (key, value) in headers {
                    appendField(name: "\(headerPrefix):\(key)", value: value)
                }
            }
            if let variables = request.variables {
                let variablePrefix = Mailgun.Messages.Send.Mime.Request.CodingKeys.variables.rawValue
                for (key, value) in variables {
                    appendField(name: "\(variablePrefix):\(key)", value: value)
                }
            }
            if let recipientVariables = request.recipientVariables {
                appendField(name: Mailgun.Messages.Send.Mime.Request.CodingKeys.recipientVariables.rawValue, value: recipientVariables)
            }

            appendClosingBoundary()
            return body
        }
    }
}
