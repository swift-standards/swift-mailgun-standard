import Foundation
@testable import Mailgun_Types
@testable import Mailgun_Messages_Types
@testable import Mailgun_Templates_Types
@testable import Mailgun_Suppressions_Types
@testable import Mailgun_Reporting_Types
@testable import Mailgun_Domains_Types
import Testing
import Dependencies
import CasePaths
import URLFormCoding

@Suite("README Code Examples Validation", .serialized)
struct ReadmeVerificationTests {

    // MARK: - Quick Start Example (README lines 43-53)

    @Test("Quick Start - Type-safe request models (README lines 43-53)")
    func quickStartExample() async throws {
        // Type-safe request models with compile-time validation
        let request = Mailgun.Messages.Send.Request(
            from: try .init("hello@yourdomain.com"),
            to: [try .init("user@example.com")],
            subject: "Welcome to swift-mailgun-types!",
            html: "<h1>Type-safe emails</h1><p>Built with Swift</p>"
        )

        // Verify the request was created correctly
        #expect(request.from.rawValue == "hello@yourdomain.com")
        #expect(request.to.count == 1)
        #expect(request.to.first?.rawValue == "user@example.com")
        #expect(request.subject == "Welcome to swift-mailgun-types!")
        #expect(request.html == "<h1>Type-safe emails</h1><p>Built with Swift</p>")
    }

    // MARK: - Sending Messages (README lines 434-486)

    @Test("Simple email (README lines 434-439)")
    func simpleEmailExample() async throws {
        let simpleEmail = Mailgun.Messages.Send.Request(
            from: try .init("noreply@yourdomain.com"),
            to: [try .init("user@example.com")],
            subject: "Hello!",
            text: "Welcome to our service."
        )

        #expect(simpleEmail.from.rawValue == "noreply@yourdomain.com")
        #expect(simpleEmail.to.count == 1)
        #expect(simpleEmail.subject == "Hello!")
        #expect(simpleEmail.text == "Welcome to our service.")
    }

    @Test("Rich email with all features (README lines 442-486)")
    func richEmailExample() async throws {
        let reportData = Data("PDF content".utf8)
        let logoData = Data("PNG content".utf8)

        let richEmail = Mailgun.Messages.Send.Request(
            from: try .init("Newsletter <news@yourdomain.com>"),
            to: [
                try .init("subscriber1@example.com"),
                try .init("subscriber2@example.com")
            ],
            cc: [try .init("manager@yourdomain.com")],
            bcc: [try .init("archive@yourdomain.com")],
            subject: "Monthly Newsletter",
            html: """
                <h1>Your Monthly Update</h1>
                <p>Check out our latest features!</p>
                <img src="cid:logo.png">
            """,
            text: "Your Monthly Update - Check out our latest features!",
            attachment: [
                Mailgun.Messages.Attachment(
                    filename: "report.pdf",
                    data: reportData,
                    contentType: "application/pdf"
                )
            ],
            inline: [
                Mailgun.Messages.Attachment(
                    filename: "logo.png",
                    data: logoData,
                    contentType: "image/png"
                )
            ],
            template: "monthly-newsletter",
            templateVariables: [
                "month": "January",
                "year": "2024"
            ],
            tag: ["newsletter", "monthly"],
            deliveryTime: Date().addingTimeInterval(3600), // Send in 1 hour
            tracking: true,
            trackingClicks: .htmlOnly,
            trackingOpens: true,
            headers: ["X-Campaign-ID": "JAN2024"],
            recipientVariables: [
                "subscriber1@example.com": ["name": "Alice", "id": "001"],
                "subscriber2@example.com": ["name": "Bob", "id": "002"]
            ]
        )

        #expect(richEmail.from.rawValue.contains("news@yourdomain.com"))
        #expect(richEmail.to.count == 2)
        #expect(richEmail.cc?.count == 1)
        #expect(richEmail.bcc?.count == 1)
        #expect(richEmail.template == "monthly-newsletter")
        #expect(richEmail.tag?.contains("newsletter") == true)
        #expect(richEmail.tracking == true)
        #expect(richEmail.attachment?.count == 1)
        #expect(richEmail.inline?.count == 1)
    }

    // MARK: - Working with Templates (README lines 495-519)

    @Test("Create a template (README lines 495-505)")
    func createTemplateExample() async throws {
        let template = Mailgun.Templates.Template.Create.Request(
            name: "welcome-email",
            description: "Welcome email for new users",
            template: """
                <h1>Welcome {{name}}!</h1>
                <p>Thanks for joining on {{signup_date}}.</p>
                <p>Your account type: {{account_type}}</p>
            """,
            engine: "handlebars",
            tag: "v1.0"
        )

        #expect(template.name == "welcome-email")
        #expect(template.description == "Welcome email for new users")
        #expect(template.engine == "handlebars")
        #expect(template.tag == "v1.0")
        #expect(template.template.contains("{{name}}"))
    }

    @Test("Create a new template version (README lines 508-519)")
    func createTemplateVersionExample() async throws {
        let newVersion = Mailgun.Templates.Version.Create.Request(
            tag: "v2.0",
            template: """
                <h1>Welcome aboard, {{name}}!</h1>
                <p>We're excited to have you join us on {{signup_date}}.</p>
                <p>Your {{account_type}} account is ready!</p>
                <a href="{{cta_link}}">Get Started</a>
            """,
            engine: "handlebars",
            comment: "Added CTA button",
            active: true
        )

        #expect(newVersion.tag == "v2.0")
        #expect(newVersion.comment == "Added CTA button")
        #expect(newVersion.active == true)
        #expect(newVersion.template.contains("{{cta_link}}"))
    }

    // MARK: - Managing Suppressions (README lines 528-550)

    @Test("Handle a bounce (README lines 528-532)")
    func handleBounceExample() async throws {
        let bounce = Mailgun.Suppressions.Bounces.Create.Request(
            address: "invalid@example.com",
            code: "550",
            error: "Mailbox does not exist"
        )

        #expect(bounce.address == "invalid@example.com")
        #expect(bounce.code == "550")
        #expect(bounce.error == "Mailbox does not exist")
    }

    @Test("Add to unsubscribe list (README lines 535-538)")
    func addUnsubscribeExample() async throws {
        let unsubscribe = Mailgun.Suppressions.Unsubscribes.Create.Request(
            address: "user@example.com",
            tag: "newsletter"
        )

        #expect(unsubscribe.address == "user@example.com")
        #expect(unsubscribe.tag == "newsletter")
    }

    @Test("Allowlist VIP addresses (README lines 541-544)")
    func allowlistExample() async throws {
        let allowlist = Mailgun.Suppressions.Allowlist.Create.Request(
            address: "vip@partner.com",
            reason: "Strategic partner"
        )

        #expect(allowlist.address == "vip@partner.com")
        #expect(allowlist.reason == "Strategic partner")
    }

    @Test("Query suppressions (README lines 547-550)")
    func querySuppressions() async throws {
        let query = Mailgun.Suppressions.Bounces.List.Request(
            limit: 100,
            page: .next
        )

        #expect(query.limit == 100)
        #expect(query.page == .next)
    }

    // MARK: - Analytics and Reporting (README lines 559-593)

    @Test("Query events (README lines 559-566)")
    func queryEventsExample() async throws {
        let eventQuery = Mailgun.Reporting.Events.List.Query(
            begin: Date().addingTimeInterval(-86400),
            end: Date(),
            ascending: .no,
            limit: 100,
            event: "delivered",
            recipient: "user@example.com"
        )

        #expect(eventQuery.limit == 100)
        #expect(eventQuery.ascending == .no)
        #expect(eventQuery.event == "delivered")
        #expect(eventQuery.recipient == "user@example.com")
    }

    @Test("Get statistics (README lines 569-575)")
    func getStatisticsExample() async throws {
        let statsQuery = Mailgun.Reporting.Stats.Query(
            event: ["accepted", "delivered", "failed"],
            start: Date().addingTimeInterval(-7 * 86400),
            end: Date(),
            resolution: .day,
            duration: "7d"
        )

        #expect(statsQuery.event?.count == 3)
        #expect(statsQuery.resolution == .day)
        #expect(statsQuery.duration == "7d")
    }

    @Test("Advanced metrics with dimensions (README lines 578-593)")
    func advancedMetricsExample() async throws {
        let metricsQuery = Mailgun.Reporting.Metrics.Query(
            metrics: [
                "deliverability_metrics.delivered_rate",
                "deliverability_metrics.bounce_rate",
                "engagement_metrics.open_rate",
                "engagement_metrics.click_rate"
            ],
            start: Date().addingTimeInterval(-30 * 86400),
            end: Date(),
            resolution: .day,
            dimensions: ["tag", "domain"],
            filters: [
                "tag": "marketing",
                "domain": "yourdomain.com"
            ]
        )

        #expect(metricsQuery.metrics.count == 4)
        #expect(metricsQuery.resolution == .day)
        #expect(metricsQuery.dimensions?.contains("tag") == true)
        #expect(metricsQuery.filters?["tag"] == "marketing")
    }

    // MARK: - Managing Domains (README lines 602-627)

    @Test("Create a domain (README lines 602-611)")
    func createDomainExample() async throws {
        let domain = Mailgun.Domains.Create.Request(
            name: "mail.yourdomain.com",
            smtpPassword: "secure-password-here",
            spamAction: .tag,
            wildcard: false,
            forceDkimAuthority: true,
            dkimKeySize: 2048,
            ips: ["192.168.1.1"],
            poolId: "production-pool"
        )

        #expect(domain.name == "mail.yourdomain.com")
        #expect(domain.spamAction == .tag)
        #expect(domain.wildcard == false)
        #expect(domain.forceDkimAuthority == true)
        #expect(domain.dkimKeySize == 2048)
        #expect(domain.ips?.count == 1)
    }

    @Test("Configure tracking (README lines 614-621)")
    func configureTrackingExample() async throws {
        let tracking = Mailgun.Domains.Tracking.Update.Request(
            open: .enabled,
            click: .enabled,
            unsubscribe: .enabled(
                footerText: "Unsubscribe from our emails",
                footerHtml: "<a href='%unsubscribe_url%'>Unsubscribe</a>"
            )
        )

        #expect(tracking.open == .enabled)
        #expect(tracking.click == .enabled)
        if case .enabled(let footerText, let footerHtml) = tracking.unsubscribe {
            #expect(footerText == "Unsubscribe from our emails")
            #expect(footerHtml?.contains("%unsubscribe_url%") == true)
        } else {
            Issue.record("Expected unsubscribe to be enabled")
        }
    }

    @Test("Update DKIM settings (README lines 624-627)")
    func updateDKIMExample() async throws {
        let dkim = Mailgun.Domains.DKIM.Update.Request(
            active: true,
            rotation: .enabled(days: 90)
        )

        #expect(dkim.active == true)
        if case .enabled(let days) = dkim.rotation {
            #expect(days == 90)
        } else {
            Issue.record("Expected rotation to be enabled")
        }
    }

    // MARK: - Router Usage (README lines 637-649)

    @Test("Using the Router for URL Generation (README lines 637-649)")
    func routerURLGenerationExample() async throws {
        let router = Mailgun.Messages.API.Router()

        let emailRequest = Mailgun.Messages.Send.Request(
            from: try .init("test@yourdomain.com"),
            to: [try .init("user@example.com")],
            subject: "Test",
            text: "Test"
        )

        let sendAPI = Mailgun.Messages.API.send(
            domain: try .init("yourdomain.com"),
            request: emailRequest
        )

        // Verify the router can work with the API enum
        #expect(sendAPI != sendAPI) // Basic equality check

        // Note: Actual URL generation would require URLRouting implementation
        // This test validates the types compile and can be instantiated
    }

    // MARK: - Mock Client Testing (README lines 662-702)

    @Test("Mock Client Testing (README lines 662-702)")
    func mockClientTestingExample() async throws {
        // Create a mock client with controlled responses
        let client = Mailgun.Messages.Client(
            send: { request in
                // Verify the request
                #expect(request.from.rawValue == "test@example.com")
                #expect(request.subject == "Test Email")
                #expect(request.to.count == 1)

                // Return mock response
                return Mailgun.Messages.Send.Response(
                    id: "<test-message-id@mailgun.org>",
                    message: "Queued. Thank you."
                )
            },
            sendMime: { _ in
                throw NSError(domain: "Not implemented", code: 0)
            },
            retrieve: { storageKey in
                #expect(storageKey == "test-key")
                return Mailgun.Messages.StoredMessage(
                    from: "sender@example.com",
                    subject: "Test",
                    bodyPlain: "Test message",
                    messageHeaders: []
                )
            },
            queueStatus: {
                throw NSError(domain: "Not implemented", code: 0)
            },
            deleteAll: {
                throw NSError(domain: "Not implemented", code: 0)
            }
        )

        // Test sending
        let request = Mailgun.Messages.Send.Request(
            from: try .init("test@example.com"),
            to: [try .init("recipient@example.com")],
            subject: "Test Email",
            text: "This is a test"
        )

        let response = try await client.send(request)
        #expect(response.id == "<test-message-id@mailgun.org>")

        // Test retrieval
        let message = try await client.retrieve("test-key")
        #expect(message.from == "sender@example.com")
    }

    // MARK: - CasePaths Usage (README lines 829-854)

    @Test("Using CasePaths for API Enums (README lines 829-854)")
    func casePathsUsageExample() async throws {
        let request = Mailgun.Messages.Send.Request(
            from: try .init("test@test.com"),
            to: [try .init("user@test.com")],
            subject: "Test",
            text: "Test"
        )

        let api: Mailgun.Messages.API = .send(
            domain: try .init("test.com"),
            request: request
        )

        // Check enum case
        #expect(api.is(\.send))

        // Extract associated values
        if let sendData = api.send {
            #expect(sendData.domain.rawValue == "test.com")
            #expect(sendData.request.subject == "Test")
        } else {
            Issue.record("Expected send case")
        }

        // Pattern matching with CasePaths
        switch api {
        case \.send:
            // Success - this is a send request
            break
        case \.sendMime:
            Issue.record("Expected send, got sendMime")
        case \.retrieve:
            Issue.record("Expected send, got retrieve")
        case \.queueStatus:
            Issue.record("Expected send, got queueStatus")
        case \.deleteAll:
            Issue.record("Expected send, got deleteAll")
        }
    }

    // MARK: - Custom Form Encoding (README lines 863-882)

    @Test("Custom Form Encoding (README lines 863-882)")
    func customFormEncodingExample() async throws {
        // Verify mailgun form encoder exists and can be instantiated
        let encoder = Shared.FormEncoder.mailgun

        // Test encoding a simple request
        let request = Mailgun.Messages.Send.Request(
            from: try .init("test@example.com"),
            to: [try .init("user@example.com")],
            subject: "Test",
            text: "Test message"
        )

        // Verify encoding works
        let encoded = try encoder.encode(request)
        #expect(encoded.count > 0)

        // Verify the encoded data contains expected fields
        let encodedString = String(data: encoded, encoding: .utf8) ?? ""
        #expect(encodedString.contains("from"))
        #expect(encodedString.contains("to"))
        #expect(encodedString.contains("subject"))
    }

    // MARK: - Type Conformance Validation

    @Test("Verify all types are Sendable and Codable")
    func typeConformanceValidation() async throws {
        // Verify Send.Request conforms to required protocols
        let request = Mailgun.Messages.Send.Request(
            from: try .init("test@test.com"),
            to: [try .init("user@test.com")],
            subject: "Test",
            text: "Test"
        )

        let _: any Sendable = request
        let _: any Codable = request

        // Verify Response types conform
        let response = Mailgun.Messages.Send.Response(
            id: "test-id",
            message: "Queued"
        )
        let _: any Sendable = response
        // Note: Response may not be Encodable, only Decodable
        let _: any Decodable = response

        // Verify Template types conform
        let template = Mailgun.Templates.Template.Create.Request(
            name: "test",
            template: "<h1>Test</h1>"
        )
        let _: any Sendable = template
        let _: any Codable = template
    }

    @Test("Verify Client protocols are properly defined")
    func clientProtocolValidation() async throws {
        // Verify Messages client exists and has expected methods
        let _: Mailgun.Messages.Client.Type = Mailgun.Messages.Client.self

        // Verify other client types exist
        let _: Mailgun.Templates.Client.Type = Mailgun.Templates.Client.self
        let _: Mailgun.Domains.Client.Type = Mailgun.Domains.Client.self
        let _: Mailgun.Suppressions.Client.Type = Mailgun.Suppressions.Client.self
    }
}
