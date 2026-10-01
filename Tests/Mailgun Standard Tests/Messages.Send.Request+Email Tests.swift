import Email_Standard
import EmailAddress_Standard
import Mailgun_Standard
import RFC_2046
import RFC_5322
import Testing
import Time

@Suite
struct `Email Conversion Tests` {

    @Test
    func `a text email converts to a send request`() throws {
        let email = try Email(
            to: [try emailAddress(localPart: "recipient", domain: "example.com")],
            from: try emailAddress(localPart: "sender", domain: "example.com"),
            date: RFC_5322.DateTime(secondsSinceEpoch: 1_609_459_200),
            subject: "Test Subject",
            body: "Hello, World!"
        )

        let request = Mailgun.Messages.Send.Request(email: email)

        #expect(request.from.address == "sender@example.com")
        #expect(request.to.count == 1)
        #expect(request.to[0].address == "recipient@example.com")
        #expect(request.subject == "Test Subject")
        #expect(request.text == "Hello, World!")
        #expect(request.html == nil)
    }

    @Test
    func `an html email converts to a send request`() throws {
        let email = try Email(
            to: [try emailAddress(localPart: "recipient", domain: "example.com")],
            from: try emailAddress(localPart: "sender", domain: "example.com"),
            date: RFC_5322.DateTime(secondsSinceEpoch: 1_609_459_200),
            subject: "Test Subject",
            body: .html("<h1>Hello, World!</h1>")
        )

        let request = Mailgun.Messages.Send.Request(email: email)

        #expect(request.from.address == "sender@example.com")
        #expect(request.to.count == 1)
        #expect(request.to[0].address == "recipient@example.com")
        #expect(request.subject == "Test Subject")
        #expect(request.html == "<h1>Hello, World!</h1>")
        #expect(request.text == nil)
    }

    @Test
    func `a multipart email converts to both text and html`() throws {
        let multipart = try RFC_2046.Multipart.alternative(
            textContent: "Plain text version",
            htmlContent: "<h1>HTML version</h1>"
        )

        let email = try Email(
            to: [try emailAddress(localPart: "recipient", domain: "example.com")],
            from: try emailAddress(localPart: "sender", domain: "example.com"),
            date: RFC_5322.DateTime(secondsSinceEpoch: 1_609_459_200),
            subject: "Test Subject",
            body: .multipart(multipart)
        )

        let request = Mailgun.Messages.Send.Request(email: email)

        #expect(request.from.address == "sender@example.com")
        #expect(request.to.count == 1)
        #expect(request.subject == "Test Subject")
        #expect(request.text == "Plain text version")
        #expect(request.html == "<h1>HTML version</h1>")
    }

    @Test
    func `multiple to recipients carry across`() throws {
        let email = try Email(
            to: [
                try emailAddress(localPart: "recipient1", domain: "example.com"),
                try emailAddress(localPart: "recipient2", domain: "example.com"),
                try emailAddress(localPart: "recipient3", domain: "example.com"),
            ],
            from: try emailAddress(localPart: "sender", domain: "example.com"),
            date: RFC_5322.DateTime(secondsSinceEpoch: 1_609_459_200),
            subject: "Test Subject",
            body: "Hello!"
        )

        let request = Mailgun.Messages.Send.Request(email: email)

        #expect(request.to.count == 3)
        #expect(request.to[0].address == "recipient1@example.com")
        #expect(request.to[1].address == "recipient2@example.com")
        #expect(request.to[2].address == "recipient3@example.com")
    }

    @Test
    func `cc recipients carry across`() throws {
        let email = try Email(
            to: [try emailAddress(localPart: "recipient", domain: "example.com")],
            from: try emailAddress(localPart: "sender", domain: "example.com"),
            cc: [
                try emailAddress(localPart: "cc1", domain: "example.com"),
                try emailAddress(localPart: "cc2", domain: "example.com"),
            ],
            date: RFC_5322.DateTime(secondsSinceEpoch: 1_609_459_200),
            subject: "Test Subject",
            body: "Hello!"
        )

        let request = Mailgun.Messages.Send.Request(email: email)

        #expect(request.cc?.count == 2)
        #expect(request.cc?[0].address == "cc1@example.com")
        #expect(request.cc?[1].address == "cc2@example.com")
    }

    @Test
    func `bcc recipients carry across`() throws {
        let email = try Email(
            to: [try emailAddress(localPart: "recipient", domain: "example.com")],
            from: try emailAddress(localPart: "sender", domain: "example.com"),
            bcc: [
                try emailAddress(localPart: "bcc1", domain: "example.com"),
                try emailAddress(localPart: "bcc2", domain: "example.com"),
            ],
            date: RFC_5322.DateTime(secondsSinceEpoch: 1_609_459_200),
            subject: "Test Subject",
            body: "Hello!"
        )

        let request = Mailgun.Messages.Send.Request(email: email)

        #expect(request.bcc?.count == 2)
        #expect(request.bcc?[0].address == "bcc1@example.com")
        #expect(request.bcc?[1].address == "bcc2@example.com")
    }

    @Test
    func `a reply-to address becomes a header`() throws {
        let email = try Email(
            to: [try emailAddress(localPart: "recipient", domain: "example.com")],
            from: try emailAddress(localPart: "sender", domain: "example.com"),
            replyTo: try emailAddress(localPart: "replyto", domain: "example.com"),
            date: RFC_5322.DateTime(secondsSinceEpoch: 1_609_459_200),
            subject: "Test Subject",
            body: "Hello!"
        )

        let request = Mailgun.Messages.Send.Request(email: email)

        #expect(request.from.address == "sender@example.com")
        #expect(request.headers?["Reply-To"] == "replyto@example.com")
    }

    @Test
    func `an email without reply-to has no reply-to header`() throws {
        let email = try Email(
            to: [try emailAddress(localPart: "recipient", domain: "example.com")],
            from: try emailAddress(localPart: "sender", domain: "example.com"),
            date: RFC_5322.DateTime(secondsSinceEpoch: 1_609_459_200),
            subject: "Test Subject",
            body: "Hello!"
        )

        let request = Mailgun.Messages.Send.Request(email: email)

        #expect(request.headers?["Reply-To"] == nil)
    }

    @Test
    func `additional headers carry across`() throws {
        let email = try Email(
            to: [try emailAddress(localPart: "recipient", domain: "example.com")],
            from: try emailAddress(localPart: "sender", domain: "example.com"),
            date: RFC_5322.DateTime(secondsSinceEpoch: 1_609_459_200),
            subject: "Test Subject",
            body: "Hello!",
            additionalHeaders: [
                .init(name: try .init("X-Custom-Header"), value: try .init("CustomValue")),
                .init(name: try .init("X-Priority"), value: try .init("1")),
            ]
        )

        let request = Mailgun.Messages.Send.Request(email: email)

        #expect(request.headers?["X-Custom-Header"] == "CustomValue")
        #expect(request.headers?["X-Priority"] == "1")
    }

    @Test
    func `an email with no additional headers has no headers`() throws {
        let email = try Email(
            to: [try emailAddress(localPart: "recipient", domain: "example.com")],
            from: try emailAddress(localPart: "sender", domain: "example.com"),
            date: RFC_5322.DateTime(secondsSinceEpoch: 1_609_459_200),
            subject: "Test Subject",
            body: "Hello!"
        )

        let request = Mailgun.Messages.Send.Request(email: email)

        #expect(request.headers == nil)
    }

    @Test
    func `reply-to and additional headers combine`() throws {
        let email = try Email(
            to: [try emailAddress(localPart: "recipient", domain: "example.com")],
            from: try emailAddress(localPart: "sender", domain: "example.com"),
            replyTo: try emailAddress(localPart: "replyto", domain: "example.com"),
            date: RFC_5322.DateTime(secondsSinceEpoch: 1_609_459_200),
            subject: "Test Subject",
            body: "Hello!",
            additionalHeaders: [
                .init(name: try .init("X-Custom-Header"), value: try .init("CustomValue"))
            ]
        )

        let request = Mailgun.Messages.Send.Request(email: email)

        #expect(request.headers?["Reply-To"] == "replyto@example.com")
        #expect(request.headers?["X-Custom-Header"] == "CustomValue")
        #expect(request.headers?.count == 2)
    }

    @Test
    func `display names carry across`() throws {
        let email = try Email(
            to: [try emailAddress(displayName: "Recipient Name", localPart: "recipient", domain: "example.com")],
            from: try emailAddress(displayName: "Sender Name", localPart: "sender", domain: "example.com"),
            date: RFC_5322.DateTime(secondsSinceEpoch: 1_609_459_200),
            subject: "Test Subject",
            body: "Hello!"
        )

        let request = Mailgun.Messages.Send.Request(email: email)

        #expect(request.from.displayName == "Sender Name")
        #expect(request.from.address == "sender@example.com")
        #expect(request.to[0].displayName == "Recipient Name")
        #expect(request.to[0].address == "recipient@example.com")
    }

    @Test
    func `mailgun options are added alongside the email`() throws {
        let email = try Email(
            to: [try emailAddress(localPart: "recipient", domain: "example.com")],
            from: try emailAddress(localPart: "sender", domain: "example.com"),
            date: RFC_5322.DateTime(secondsSinceEpoch: 1_609_459_200),
            subject: "Test Subject",
            body: "Hello!"
        )

        let request = Mailgun.Messages.Send.Request(
            email: email,
            tags: ["newsletter", "announcement"],
            testMode: true,
            tracking: .yes,
            trackingClicks: .yes,
            trackingOpens: true
        )

        #expect(request.tags == ["newsletter", "announcement"])
        #expect(request.tracking == .yes)
        #expect(request.trackingClicks == .yes)
        #expect(request.trackingOpens == true)
        #expect(request.testMode == true)
    }

    @Test
    func `mailgun variables are added alongside the email`() throws {
        let email = try Email(
            to: [try emailAddress(localPart: "recipient", domain: "example.com")],
            from: try emailAddress(localPart: "sender", domain: "example.com"),
            date: RFC_5322.DateTime(secondsSinceEpoch: 1_609_459_200),
            subject: "Test Subject",
            body: "Hello!"
        )

        let request = Mailgun.Messages.Send.Request(
            email: email,
            variables: ["user_id": "123", "campaign": "summer-sale"]
        )

        #expect(request.variables?["user_id"] == "123")
        #expect(request.variables?["campaign"] == "summer-sale")
    }

    @Test
    func `a scheduled delivery time is added alongside the email`() throws {
        let email = try Email(
            to: [try emailAddress(localPart: "recipient", domain: "example.com")],
            from: try emailAddress(localPart: "sender", domain: "example.com"),
            date: RFC_5322.DateTime(secondsSinceEpoch: 1_609_459_200),
            subject: "Test Subject",
            body: "Hello!"
        )

        let deliveryDate = Time.Instant(secondsSinceUnixEpoch: 1_700_000_000)
        let request = Mailgun.Messages.Send.Request(
            email: email,
            deliveryTime: deliveryDate
        )

        #expect(request.deliveryTime == deliveryDate)
    }

    @Test
    func `internationalized addresses carry across`() throws {
        let email = try Email(
            to: [try emailAddress(localPart: "用户", domain: "example.com")],
            from: try emailAddress(localPart: "发送者", domain: "example.com"),
            date: RFC_5322.DateTime(secondsSinceEpoch: 1_609_459_200),
            subject: "国际化测试",
            body: "你好世界!"
        )

        let request = Mailgun.Messages.Send.Request(email: email)

        #expect(request.from.address == "发送者@example.com")
        #expect(request.to[0].address == "用户@example.com")
        #expect(request.subject == "国际化测试")
        #expect(request.text == "你好世界!")
    }

    @Test
    func `a subject with special characters carries across`() throws {
        let email = try Email(
            to: [try emailAddress(localPart: "recipient", domain: "example.com")],
            from: try emailAddress(localPart: "sender", domain: "example.com"),
            date: RFC_5322.DateTime(secondsSinceEpoch: 1_609_459_200),
            subject: "Test with émojis 🎉 and spëcial çhars!",
            body: "Hello!"
        )

        let request = Mailgun.Messages.Send.Request(email: email)

        #expect(request.subject == "Test with émojis 🎉 and spëcial çhars!")
    }

    @Test
    func `a very long subject carries across`() throws {
        let longSubject = String(repeating: "A", count: 200)
        let email = try Email(
            to: [try emailAddress(localPart: "recipient", domain: "example.com")],
            from: try emailAddress(localPart: "sender", domain: "example.com"),
            date: RFC_5322.DateTime(secondsSinceEpoch: 1_609_459_200),
            subject: longSubject,
            body: "Hello!"
        )

        let request = Mailgun.Messages.Send.Request(email: email)

        #expect(request.subject == longSubject)
        #expect(request.subject.count == 200)
    }

    @Test
    func `the convenience initializer leaves mailgun options unset`() throws {
        let email = try Email(
            to: [try emailAddress(localPart: "recipient", domain: "example.com")],
            from: try emailAddress(localPart: "sender", domain: "example.com"),
            date: RFC_5322.DateTime(secondsSinceEpoch: 1_609_459_200),
            subject: "Test Subject",
            body: "Hello!"
        )

        let request = Mailgun.Messages.Send.Request(email: email)

        #expect(request.from.address == "sender@example.com")
        #expect(request.to.count == 1)
        #expect(request.subject == "Test Subject")
        #expect(request.text == "Hello!")

        #expect(request.tags == nil)
        #expect(request.tracking == nil)
        #expect(request.testMode == nil)
    }
}
