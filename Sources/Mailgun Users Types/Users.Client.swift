//
//  File.swift
//  coenttb-mailgun
//
//  Created by Coen ten Thije Boonkkamp on 24/12/2024.
//

import DependenciesMacros
import Mailgun_Types_Shared

extension Mailgun.Users {
    @DependencyClient
    public struct Client: Sendable {
        @DependencyEndpoint
        public var list: @Sendable (_ request: Mailgun.Users.List.Request?) async throws -> Mailgun.Users.List.Response

        @DependencyEndpoint
        public var get: @Sendable (_ userId: String) async throws -> Mailgun.Users.Get.Response

        @DependencyEndpoint
        public var me: @Sendable () async throws -> Mailgun.Users.Me.Response

        @DependencyEndpoint
        public var addToOrganization: @Sendable (_ userId: String, _ orgId: String) async throws -> Mailgun.Users.Organization.Add.Response

        @DependencyEndpoint
        public var removeFromOrganization: @Sendable (_ userId: String, _ orgId: String) async throws -> Mailgun.Users.Organization.Remove.Response
    }
}
