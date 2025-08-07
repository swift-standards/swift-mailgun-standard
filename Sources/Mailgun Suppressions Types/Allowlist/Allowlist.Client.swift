//
//  File.swift
//  coenttb-mailgun
//
//  Created by Coen ten Thije Boonkkamp on 24/12/2024.
//

import DependenciesMacros
import Mailgun_Types_Shared

extension Mailgun.Suppressions.Allowlist {
    @DependencyClient
    public struct Client: Sendable {
        @DependencyEndpoint
        public var get: @Sendable (_ value: String) async throws -> Mailgun.Suppressions.Allowlist.Record

        @DependencyEndpoint
        public var delete: @Sendable (_ value: String) async throws -> Mailgun.Suppressions.Allowlist.Delete.Response

        @DependencyEndpoint
        public var list: @Sendable (_ request: Mailgun.Suppressions.Allowlist.List.Request?) async throws -> Mailgun.Suppressions.Allowlist.List.Response

        @DependencyEndpoint
        public var create: @Sendable (_ request: Mailgun.Suppressions.Allowlist.Create.Request) async throws -> Mailgun.Suppressions.Allowlist.Create.Response

        @DependencyEndpoint
        public var deleteAll: @Sendable () async throws -> Mailgun.Suppressions.Allowlist.Delete.All.Response

        @DependencyEndpoint
        public var importList: @Sendable (_ request: Foundation.Data) async throws -> Mailgun.Suppressions.Allowlist.Import.Response
    }
}
