import Byte
import Byte
import EmailAddress_Standard
import Mailgun_Standard
import Testing
import Time

@Suite
struct `README Tests` {

    @Test
    func `a send request carries a from address, recipients, a subject and html`() throws {
        let request = Mailgun.Messages.Send.Request(
            from: try emailAddress(localPart: "hello", domain: "yourdomain.com"),
            to: [try emailAddress(localPart: "user", domain: "example.com")],
            subject: "Welcome to swift-mailgun-types!",
            html: "<h1>Type-safe emails</h1><p>Built with Swift</p>"
        )

        #expect(request.from.address == "hello@yourdomain.com")
        #expect(request.to.count == 1)
        #expect(request.to.first?.address == "user@example.com")
        #expect(request.subject == "Welcome to swift-mailgun-types!")
        #expect(request.html == "<h1>Type-safe emails</h1><p>Built with Swift</p>")
    }

    @Test
    func `a plain text send request needs only four fields`() throws {
        let simpleEmail = Mailgun.Messages.Send.Request(
            from: try emailAddress(localPart: "noreply", domain: "yourdomain.com"),
            to: [try emailAddress(localPart: "user", domain: "example.com")],
            subject: "Hello!",
            text: "Welcome to our service."
        )

        #expect(simpleEmail.from.address == "noreply@yourdomain.com")
        #expect(simpleEmail.to.count == 1)
        #expect(simpleEmail.subject == "Hello!")
        #expect(simpleEmail.text == "Welcome to our service.")
    }

    @Test
    func `a rich send request carries attachments, tags, tracking and a delivery time`() throws {
        let reportData: [Byte] = .init(utf8: "PDF content")
        let logoData: [Byte] = .init(utf8: "PNG content")

        let richEmail = Mailgun.Messages.Send.Request(
            from: try emailAddress(displayName: "Newsletter", localPart: "news", domain: "yourdomain.com"),
            to: [
                try emailAddress(localPart: "subscriber1", domain: "example.com"),
                try emailAddress(localPart: "subscriber2", domain: "example.com"),
            ],
            subject: "Monthly Newsletter",
            html: """
                    <h1>Your Monthly Update</h1>
                    <p>Check out our latest features!</p>
                    <img src="cid:logo.png">
                """,
            text: "Your Monthly Update - Check out our latest features!",
            cc: [try emailAddress(localPart: "manager", domain: "yourdomain.com")],
            bcc: [try emailAddress(localPart: "archive", domain: "yourdomain.com")],
            template: "monthly-newsletter",
            templateVariables: #"{"month":"January","year":"2024"}"#,
            attachments: [
                Mailgun.Messages.Attachment.Data(
                    data: reportData,
                    filename: "report.pdf",
                    contentType: "application/pdf"
                )
            ],
            inline: [
                Mailgun.Messages.Attachment.Data(
                    data: logoData,
                    filename: "logo.png",
                    contentType: "image/png"
                )
            ],
            tags: ["newsletter", "monthly"],

            deliveryTime: Time.Instant(secondsSinceUnixEpoch: 1_700_003_600),
            tracking: true,
            trackingClicks: .htmlOnly,
            trackingOpens: true,
            headers: ["X-Campaign-ID": "JAN2024"],

            recipientVariables: #"{"subscriber1@example.com":{"name":"Alice","id":"001"}}"#
        )

        #expect(richEmail.from.address.contains("news@yourdomain.com"))
        #expect(richEmail.to.count == 2)
        #expect(richEmail.cc?.count == 1)
        #expect(richEmail.bcc?.count == 1)
        #expect(richEmail.template == "monthly-newsletter")
        #expect(richEmail.tags?.contains("newsletter") == true)
        #expect(richEmail.tracking == true)
        #expect(richEmail.attachments?.count == 1)
        #expect(richEmail.inline?.count == 1)
        #expect(richEmail.deliveryTime?.secondsSinceUnixEpoch == 1_700_003_600)
    }

    @Test
    func `a send response reports the queued message identifier`() {
        let response = Mailgun.Messages.Send.Response(
            id: "<20240101120000.1.ABCDEF@yourdomain.com>",
            message: "Queued. Thank you."
        )

        #expect(response.id == "<20240101120000.1.ABCDEF@yourdomain.com>")
        #expect(response.message == "Queued. Thank you.")
    }

    @Test
    func `a template is created with a body, a tag and a comment`() {
        let template = Mailgun.Templates.Create.Request(
            name: "welcome-email",
            description: "Welcome email for new users",
            template: """
                    <h1>Welcome {{name}}!</h1>
                    <p>Thanks for joining on {{signup_date}}.</p>
                    <p>Your account type: {{account_type}}</p>
                """,
            tag: "v1.0",
            comment: "Initial version"
        )

        #expect(template.name == "welcome-email")
        #expect(template.description == "Welcome email for new users")
        #expect(template.template?.contains("{{name}}") == true)
    }

    @Test
    func `a new template version is created from the template body`() {
        let newVersion = Mailgun.Templates.Version.Create.Request(
            template: """
                    <h1>Welcome aboard, {{name}}!</h1>
                    <p>We're excited to have you join us on {{signup_date}}.</p>
                    <p>Your {{account_type}} account is ready!</p>
                    <a href="{{cta_link}}">Get Started</a>
                """,
            tag: "v2.0",
            comment: "Added CTA button",
            active: "yes"
        )

        #expect(newVersion.tag == "v2.0")
        #expect(newVersion.comment == "Added CTA button")
        #expect(newVersion.active == "yes")
        #expect(newVersion.template.contains("{{cta_link}}"))
    }

    @Test
    func `a bounce is suppressed with its SMTP code and error text`() throws {
        let bounce = Mailgun.Suppressions.Bounces.Create.Request(
            address: try emailAddress(localPart: "invalid", domain: "example.com"),
            code: "550",
            error: "Mailbox does not exist"
        )

        #expect(bounce.address.address == "invalid@example.com")
        #expect(bounce.code == "550")
        #expect(bounce.error == "Mailbox does not exist")
    }

    @Test
    func `an address is added to the unsubscribe list for a tag`() throws {
        let unsubscribe = Mailgun.Suppressions.Unsubscribe.Create.Request(
            address: try emailAddress(localPart: "user", domain: "example.com"),
            tags: ["newsletter"]
        )

        #expect(unsubscribe.address.address == "user@example.com")
        #expect(unsubscribe.tags?.contains("newsletter") == true)
    }

    @Test
    func `an allowlist entry is either an address or a domain`() throws {
        let allowlist = Mailgun.Suppressions.Allowlist.Create.Request.address(
            try emailAddress(localPart: "vip", domain: "partner.com")
        )

        if case .address(let email) = allowlist {
            #expect(email.address == "vip@partner.com")
        } else {
            Issue.record("Expected address case")
        }
    }

    @Test
    func `a suppression list is queried by page, limit and search term`() {
        let query = Mailgun.Suppressions.Bounces.List.Request(
            limit: 100,
            page: "next",
            term: "example.com"
        )

        #expect(query.limit == 100)
        #expect(query.page == "next")
        #expect(query.term == "example.com")
    }

    @Test
    func `total stats are queried by event, window and resolution`() {
        let statsQuery = Mailgun.Reporting.Stats.Total.Request(
            event: "delivered",
            start: "2024-01-01",
            end: "2024-01-31",
            resolution: "day",
            duration: "1M"
        )

        #expect(statsQuery.event == "delivered")
        #expect(statsQuery.start == "2024-01-01")
        #expect(statsQuery.resolution == "day")
        #expect(statsQuery.duration == "1M")
    }

    @Test
    func `account metrics are queried with dimensions and a filter`() {
        let metricsFilter = Mailgun.Reporting.Metrics.Filter(
            and: [
                Mailgun.Reporting.Metrics.FilterCondition(
                    attribute: "status",
                    comparator: "eq",
                    values: [
                        Mailgun.Reporting.Metrics.FilterValue(
                            label: "Delivered",
                            value: "delivered"
                        )
                    ]
                )
            ]
        )

        let metricsQuery = Mailgun.Reporting.Metrics.GetAccountMetrics.Request(
            start: "2024-01-01",
            end: "2024-01-31",
            resolution: "day",
            duration: "1M",
            dimensions: ["campaign"],
            metrics: ["delivered_count"],
            filter: metricsFilter,
            includeSubaccounts: true,
            includeAggregates: true
        )

        #expect(metricsQuery.metrics.count == 1)
        #expect(metricsQuery.resolution == "day")
        #expect(metricsQuery.dimensions.contains("campaign") == true)
        #expect(metricsQuery.includeSubaccounts == true)
    }

    @Test
    func `a domain is created from its name`() {
        let createRequest = Mailgun.Domains.Domains.Create.Request(
            name: "mail.yourdomain.com"
        )

        #expect(createRequest.name == "mail.yourdomain.com")
    }

    @Test
    func `a domain update changes only the fields it names`() {
        let updateRequest = Mailgun.Domains.Domains.Update.Request(
            spamAction: .tag
        )

        #expect(updateRequest.spamAction == .tag)
    }

    @Test
    func `domains are listed by authority, state and page window`() {
        let listRequest = Mailgun.Domains.Domains.List.Request(
            authority: "example.com",
            state: .active,
            limit: 10,
            skip: 0
        )

        #expect(listRequest.authority == "example.com")
        #expect(listRequest.state == .active)
        #expect(listRequest.limit == 10)
        #expect(listRequest.skip == 0)
    }
}
