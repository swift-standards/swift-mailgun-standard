//
//  File.swift
//  swift-mailgun
//
//  Created by Coen ten Thije Boonkkamp on 24/12/2024.
//

import DependenciesTestSupport
@testable import Mailgun_IPPools_Types
import Testing

@Suite("IP Pools Router Tests")
struct IPPoolsRouterTests {

    @Test("Creates correct URL for listing IP pools")
    func testListIPPoolsURL() throws {
        let router: Mailgun.IPPools.API.Router = .init()

        let api: Mailgun.IPPools.API = .list

        let url = router.url(for: api)
        #expect(url.path == "/v1/ip_pools")

        let match: Mailgun.IPPools.API = try router.match(request: try router.request(for: api))
        #expect(match.is(\.list))
    }
}
