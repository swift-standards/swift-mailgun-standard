//
//  File.swift
//  swift-mailgun
//
//  Created by Coen ten Thije Boonkkamp on 19/12/2024.
//

import DependenciesMacros
import Mailgun_Types_Shared

extension Mailgun.Lists {
    @DependencyClient
    public struct Client: Sendable {
        @DependencyEndpoint
        public var create: @Sendable (_ request: Mailgun.Lists.List.Create.Request) async throws -> Mailgun.Lists.List.Create.Response

        @DependencyEndpoint
        public var list: @Sendable (_ request: Mailgun.Lists.List.Request) async throws -> Mailgun.Lists.List.Response

        @DependencyEndpoint
        public var members: @Sendable (_ listAddress: EmailAddress, _ request: Mailgun.Lists.List.Members.Request) async throws -> Mailgun.Lists.List.Members.Response

        @DependencyEndpoint
        public var addMember: @Sendable (_ listAddress: EmailAddress, _ request: Mailgun.Lists.Member.Add.Request) async throws -> Mailgun.Lists.Member.Add.Response

        @DependencyEndpoint
        public var bulkAdd: @Sendable (_ listAddress: EmailAddress, _ members: [Mailgun.Lists.Member.Bulk], _ upsert: Bool?) async throws -> Mailgun.Lists.Member.Bulk.Response

        @DependencyEndpoint
        public var bulkAddCSV: @Sendable (_ listAddress: EmailAddress, _ csvData: Foundation.Data, _ subscribed: Bool?, _ upsert: Bool?) async throws -> Mailgun.Lists.Member.Bulk.Response

        @DependencyEndpoint
        public var getMember: @Sendable (_ listAddress: EmailAddress, _ memberAddress: EmailAddress) async throws -> Mailgun.Lists.Member

        @DependencyEndpoint
        public var updateMember: @Sendable (_ listAddress: EmailAddress, _ memberAddress: EmailAddress, _ request: Mailgun.Lists.Member.Update.Request) async throws -> Mailgun.Lists.Member.Update.Response

        @DependencyEndpoint
        public var deleteMember: @Sendable (_ listAddress: EmailAddress, _ memberAddress: EmailAddress) async throws -> Mailgun.Lists.Member.Delete.Response

        @DependencyEndpoint
        public var update: @Sendable (_ listAddress: EmailAddress, _ request: Mailgun.Lists.List.Update.Request) async throws -> Mailgun.Lists.List.Update.Response

        @DependencyEndpoint
        public var delete: @Sendable (_ listAddress: EmailAddress) async throws -> Mailgun.Lists.List.Delete.Response

        @DependencyEndpoint
        public var get: @Sendable (_ listAddress: EmailAddress) async throws -> Mailgun.Lists.List.Get.Response

        @DependencyEndpoint
        public var pages: @Sendable (_ limit: Int?) async throws -> Mailgun.Lists.List.Pages.Response

        @DependencyEndpoint
        public var memberPages: @Sendable (_ listAddress: EmailAddress, _ request: Mailgun.Lists.List.Members.Pages.Request) async throws -> Mailgun.Lists.List.Members.Pages.Response
    }
}

extension Mailgun.Lists.Client {
    public func pages() async throws -> Mailgun.Lists.List.Pages.Response {
        return try await self.pages(limit: nil)
    }
}
