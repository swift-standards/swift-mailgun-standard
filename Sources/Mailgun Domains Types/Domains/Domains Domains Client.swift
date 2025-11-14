//
//  File.swift
//  swift-mailgun
//
//  Created by Coen ten Thije Boonkkamp on 24/12/2024.
//

import Dependencies
import DependenciesMacros
import Mailgun_Types_Shared

extension Mailgun.Domains.Domains {
    @DependencyClient
    public struct Client: Sendable {
        @DependencyEndpoint
        public var list:
            @Sendable (_ request: Mailgun.Domains.Domains.List.Request?) async throws ->
                Mailgun.Domains.Domains.List.Response

        @DependencyEndpoint
        public var create:
            @Sendable (_ request: Mailgun.Domains.Domains.Create.Request) async throws ->
                Mailgun.Domains.Domains.Create.Response

        @DependencyEndpoint
        public var get:
            @Sendable (_ domain: Domain) async throws ->
                Mailgun.Domains.Domains.Get.Response

        @DependencyEndpoint
        public var update:
            @Sendable (
                _ domain: Domain, _ request: Mailgun.Domains.Domains.Update.Request
            ) async throws -> Mailgun.Domains.Domains.Update.Response

        @DependencyEndpoint
        public var delete:
            @Sendable (_ domain: Domain) async throws ->
                Mailgun.Domains.Domains.Delete.Response

        @DependencyEndpoint
        public var verify:
            @Sendable (_ domain: Domain) async throws ->
                Mailgun.Domains.Domains.Verify.Response
    }
}
