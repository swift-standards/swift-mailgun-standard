//
//  File.swift
//  swift-mailgun
//
//  Created by Coen ten Thije Boonkkamp on 24/12/2024.
//

import DependenciesMacros
@_exported import Mailgun_Types_Shared

extension Mailgun.IPPools {
    @DependencyClient
    public struct Client: Sendable {
        @DependencyEndpoint
        public var list: @Sendable () async throws -> Mailgun.IPPools.List.Response

        @DependencyEndpoint
        public var create: @Sendable (_ request: Mailgun.IPPools.Create.Request) async throws -> Mailgun.IPPools.Create.Response

        @DependencyEndpoint
        public var get: @Sendable (_ poolId: String) async throws -> Mailgun.IPPools.IPPool

        @DependencyEndpoint
        public var update: @Sendable (_ poolId: String, _ request: Mailgun.IPPools.Update.Request) async throws -> Mailgun.IPPools.Update.Response

        @DependencyEndpoint
        public var delete: @Sendable (_ poolId: String, _ request: Mailgun.IPPools.Delete.Request?) async throws -> Mailgun.IPPools.Delete.Response

        @DependencyEndpoint
        public var listDomains: @Sendable (_ poolId: String) async throws -> Mailgun.IPPools.DomainsList.Response
    }
}
