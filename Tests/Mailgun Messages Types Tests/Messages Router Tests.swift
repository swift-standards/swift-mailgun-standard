//
//  File.swift
//  coenttb-mailgun
//
//  Created by Coen ten Thije Boonkkamp on 20/12/2024.
//

import DependenciesTestSupport
@testable import Mailgun_Messages_Types
import Testing

@Suite("Messages Router Tests")
struct MessagesRouterTests {

    @Test("Creates correct URL for sending message")
    func testSendMessageURL() throws {
        let router: Mailgun.Messages.API.Router = .init()

        let sendRequest = Mailgun.Messages.Send.Request(
            from: try .init("sender@test.com"),
            to: [try .init("recipient@test.com")],
            subject: "Test Subject",
            html: "<p>Test content</p>",
            text: "Test content",
            cc: [try .init("cc@test.com")],
            bcc: [try .init("bcc@test.com")],
            tags: ["test-tag"],
            testMode: true
        )

        let api: Mailgun.Messages.API = .send(domain: try .init("test.domain.com"), request: sendRequest)

        let url = router.url(for: api)
        #expect(url.path == "/v3/test.domain.com/messages")

        let match: Mailgun.Messages.API = try router.match(request: try router.request(for: api))
        #expect(match.is(\.send))
        #expect(match.send?.domain == (try .init("test.domain.com")))
        #expect(match.send?.request.from.rawValue == "sender@test.com")
        #expect(match.send?.request.to.map(\.rawValue) == ["recipient@test.com"])
        #expect(match.send?.request.subject == "Test Subject")
        #expect(match.send?.request.html == "<p>Test content</p>")
        #expect(match.send?.request.text == "Test content")
        #expect(match.send?.request.cc?.map(\.rawValue) == ["cc@test.com"])
        #expect(match.send?.request.bcc?.map(\.rawValue) == ["bcc@test.com"])
        #expect(match.send?.request.tags == ["test-tag"])
        #expect(match.send?.request.testMode == true)
    }

    @Test("Creates correct URL for sending MIME message")
    func testSendMimeMessageURL() throws {
        let router: Mailgun.Messages.API.Router = .init()

        let mimeRequest = Mailgun.Messages.Send.Mime.Request(
            to: [try .init("recipient@test.com")],
            message: Foundation.Data("MIME content".utf8),
            tags: ["test-tag"],
            testMode: true
        )

        let api: Mailgun.Messages.API = .sendMime(domain: try .init("test.domain.com"), request: mimeRequest)

        let url = router.url(for: api)
        #expect(url.path == "/v3/test.domain.com/messages.mime")

        let match: Mailgun.Messages.API = try router.match(request: try router.request(for: api))
        #expect(match.is(\.sendMime))
        #expect(match.sendMime?.domain == (try .init("test.domain.com")))
        #expect(match.sendMime?.request.to.map(\.rawValue) == ["recipient@test.com"])
        #expect(match.sendMime?.request.message == Foundation.Data("MIME content".utf8))
        #expect(match.sendMime?.request.tags == ["test-tag"])
        #expect(match.sendMime?.request.testMode == true)
    }

    @Test("Creates correct URL for retrieving stored message")
    func testRetrieveMessageURL() throws {
        let router: Mailgun.Messages.API.Router = .init()

        let api: Mailgun.Messages.API = .retrieve(
            domain: try .init("test.domain.com"),
            storageKey: "message123"
        )

        let url = router.url(for: api)
        #expect(url.path == "/v3/domains/test.domain.com/messages/message123")

        let match: Mailgun.Messages.API = try router.match(request: try router.request(for: api))
        #expect(match.is(\.retrieve))
        #expect(match.retrieve?.domain == (try .init("test.domain.com")))
        #expect(match.retrieve?.storageKey == "message123")
    }

    @Test("Creates correct URL for queue status")
    func testQueueStatusURL() throws {
        let router: Mailgun.Messages.API.Router = .init()

        let api: Mailgun.Messages.API = .queueStatus(domain: try .init("test.domain.com"))

        let url = router.url(for: api)
        #expect(url.path == "/v3/domains/test.domain.com/sending_queues")

        let match: Mailgun.Messages.API = try router.match(request: try router.request(for: api))
        #expect(match.is(\.queueStatus))
        #expect(match.queueStatus == (try .init("test.domain.com")))
    }

    @Test("Creates correct URL for deleting scheduled messages")
    func testDeleteScheduledURL() throws {
        let router: Mailgun.Messages.API.Router = .init()

        let api: Mailgun.Messages.API = .deleteScheduled(domain: try .init("test.domain.com"))

        let url = router.url(for: api)
        #expect(url.path == "/v3/test.domain.com/envelopes")

        let match: Mailgun.Messages.API = try router.match(request: try router.request(for: api))
        #expect(match.is(\.deleteScheduled))
        #expect(match.deleteScheduled == (try .init("test.domain.com")))
    }
}
