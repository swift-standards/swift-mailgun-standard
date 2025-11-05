//
//  File.swift
//  swift-mailgun
//
//  Created by Coen ten Thije Boonkkamp on 24/12/2024.
//

import DependenciesMacros
import Mailgun_Types_Shared

extension Mailgun.IPAllowlist {
    @DependencyClient
    public struct Client: Sendable {
        @DependencyEndpoint
        public var list: @Sendable () async throws -> Mailgun.IPAllowlist.ListResponse

        @DependencyEndpoint
        public var update:
            @Sendable (_ request: Mailgun.IPAllowlist.UpdateRequest) async throws ->
                Mailgun.IPAllowlist.SuccessResponse

        @DependencyEndpoint
        public var add:
            @Sendable (_ request: Mailgun.IPAllowlist.AddRequest) async throws ->
                Mailgun.IPAllowlist.SuccessResponse

        @DependencyEndpoint
        public var delete:
            @Sendable (_ request: Mailgun.IPAllowlist.DeleteRequest) async throws ->
                Mailgun.IPAllowlist.SuccessResponse
    }
}
