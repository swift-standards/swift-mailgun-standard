//
//  File.swift
//  swift-mailgun
//
//  Created by Coen ten Thije Boonkkamp on 24/12/2024.
//

import DependenciesMacros
import Mailgun_Types_Shared

extension Mailgun.Keys {
    @DependencyClient
    public struct Client: Sendable {
        @DependencyEndpoint
        public var list: @Sendable () async throws -> Mailgun.Keys.List.Response

        @DependencyEndpoint
        public var create: @Sendable (_ request: Mailgun.Keys.Create.Request) async throws -> Mailgun.Keys.Create.Response

        @DependencyEndpoint
        public var delete: @Sendable (_ keyId: String) async throws -> Mailgun.Keys.Delete.Response

        @DependencyEndpoint
        public var addPublicKey: @Sendable (_ request: Mailgun.Keys.PublicKey.Request) async throws -> Mailgun.Keys.PublicKey.Response
    }
}
