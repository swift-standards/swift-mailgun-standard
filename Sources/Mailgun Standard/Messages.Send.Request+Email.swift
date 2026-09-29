import Byte
public import Email_Standard
import EmailAddress_Standard
import RFC_2045
import RFC_2046
import RFC_5322
public import Time

extension Mailgun.Messages.Send.Request {

    public init(
        email: Email,
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
        deliveryTime: Instant? = nil,
        deliveryTimeOptimizePeriod: String? = nil,
        timeZoneLocalize: String? = nil,
        testMode: Bool? = nil,
        tracking: Mailgun.Messages.Tracking.Option? = nil,
        trackingClicks: Mailgun.Messages.Tracking.Option? = nil,
        trackingOpens: Bool? = nil,
        trackingPixelLocationTop: Bool? = nil,
        requireTls: Bool? = nil,
        skipVerification: Bool? = nil,
        sendingIp: String? = nil,
        sendingIpPool: String? = nil,
        variables: [String: String]? = nil,
        recipientVariables: String? = nil
    ) {

        var headers = email.additionalHeaders
        if let replyTo = email.replyTo {
            headers[.replyTo] = replyTo.address
        }

        let headersDict: [String: String]? =
            headers.isEmpty
            ? nil
            : Dictionary(
                uniqueKeysWithValues: headers.map { ($0.name.rawValue, $0.value.rawValue) }
            )

        let (text, html) = Self.convertBody(email.body)

        self.init(
            from: email.from,
            to: email.to,
            subject: email.subject,
            html: html,
            text: text,
            cc: email.cc,
            bcc: email.bcc,
            ampHtml: ampHtml,
            template: template,
            templateVersion: templateVersion,
            templateText: templateText,
            templateVariables: templateVariables,
            attachments: attachments,
            inline: inline,
            tags: tags,
            dkim: dkim,
            secondaryDkim: secondaryDkim,
            secondaryDkimPublic: secondaryDkimPublic,
            deliveryTime: deliveryTime,
            deliveryTimeOptimizePeriod: deliveryTimeOptimizePeriod,
            timeZoneLocalize: timeZoneLocalize,
            testMode: testMode,
            tracking: tracking,
            trackingClicks: trackingClicks,
            trackingOpens: trackingOpens,
            requireTls: requireTls,
            skipVerification: skipVerification,
            sendingIp: sendingIp,
            sendingIpPool: sendingIpPool,
            trackingPixelLocationTop: trackingPixelLocationTop,
            headers: headersDict,
            variables: variables,
            recipientVariables: recipientVariables
        )
    }

    private static func convertBody(_ body: Email.Body) -> (text: String?, html: String?) {
        switch body {
        case .text(let data, _):
            return (text: String(decoding: data, as: UTF8.self), html: nil)

        case .html(let data, _):
            return (text: nil, html: String(decoding: data, as: UTF8.self))

        case .multipart(let multipart):

            var textPart: String?
            var htmlPart: String?

            for part in multipart.parts {
                if let contentType = part.contentType {
                    if contentType.type == "text" && contentType.subtype == "plain" {
                        textPart = part.content.description
                    } else if contentType.type == "text" && contentType.subtype == "html" {
                        htmlPart = part.content.description
                    }
                }
            }

            return (text: textPart, html: htmlPart)
        }
    }
}

extension Mailgun.Messages.Send.Request {

    public init(email: Email) {
        self.init(
            email: email,
            testMode: nil
        )
    }
}
