//
//  File.swift
//  swift-mailgun
//
//  Created by Coen ten Thije Boonkkamp on 24/12/2024.
//

import DependenciesTestSupport
@testable import Mailgun_Routes_Types
import Testing

@Suite(
    "Routes Router Tests"
)
struct RoutesRouterTests {
    @Test("Creates correct URL for creating a route")
    func testCreateRouteURL() throws {
        let router: Mailgun.Routes.API.Router = .init()

        let request = Mailgun.Routes.Create.Request(
            priority: 0,
            description: "Sample route",
            expression: "match_recipient(\".*@example.com\")",
            action: ["forward(\"http://example.com/webhook\")", "stop()"]
        )

        let api: Mailgun.Routes.API = .create(request: request)

        let url = router.url(for: api)
        #expect(url.path == "/v3/routes")

        let match: Mailgun.Routes.API = try router.match(request: try router.request(for: api))
        #expect(match.is(\.create))
        #expect(match.create?.priority == 0)
    }

    @Test("Verifies all endpoints use v3 API version")
    func testAllEndpointsUseV3() throws {
        let router: Mailgun.Routes.API.Router = .init()

        let apis: [Mailgun.Routes.API] = [
            .create(request: .init(priority: 0, description: "Test", expression: "test", action: [])),
            .list(limit: nil, skip: nil),
            .get(id: "test"),
            .update(id: "test", request: .init()),
            .delete(id: "test"),
            .match(address: "test@example.com")
        ]

        for api in apis {
            let url = router.url(for: api)
            #expect(url.path.hasPrefix("/v3/"))
        }
    }
}
