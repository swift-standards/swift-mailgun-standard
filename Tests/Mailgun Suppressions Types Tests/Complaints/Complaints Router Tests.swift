//
//  File.swift
//  coenttb-mailgun
//
//  Created by Coen ten Thije Boonkkamp on 27/12/2024.
//

import DependenciesTestSupport
import Domain
import EmailAddress
@testable import Mailgun_Suppressions_Types
import Testing

@Suite(
    "Complaints Router Tests"
)
struct ComplaintsRouterTests {

    @Test("Creates correct URL for importing complaints list")
    func testImportComplaintsURL() throws {
        let router: Mailgun.Suppressions.Complaints.API.Router = .init()

        let testData = Data("test".utf8)
        let request = Mailgun.Suppressions.Complaints.Import.Request(file: testData)
        let api: Mailgun.Suppressions.Complaints.API = .importList(domain: try .init("test.domain.com"), request: request)

        let url = router.url(for: api)
        #expect(url.path == "/v3/test.domain.com/complaints/import")

        // Note: Import endpoints use multipart form data which doesn't support round-trip testing
        // due to the complex nature of multipart boundary generation and Data encoding
    }

    @Test("Creates correct URL for getting specific complaint")
    func testGetComplaintURL() throws {
        let router: Mailgun.Suppressions.Complaints.API.Router = .init()

        let api: Mailgun.Suppressions.Complaints.API = .get(
            domain: try .init("test.domain.com"),
            address: try .init("test@example.com")
        )

        let url = router.url(for: api)
        #expect(url.path == "/v3/test.domain.com/complaints/test@example.com")

        let match: Mailgun.Suppressions.Complaints.API = try router.match(request: try router.request(for: api))
        #expect(match.is(\.get))
        #expect(match.get?.domain == (try .init("test.domain.com")))
    }
}
