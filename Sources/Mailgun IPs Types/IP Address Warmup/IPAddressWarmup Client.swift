//
//  IPAddressWarmup Client.swift
//  swift-mailgun-types
//
//  Created by Assistant on 05/08/2025.
//

import Dependencies
import DependenciesMacros
import Mailgun_Types_Shared

extension Mailgun.IPAddressWarmup {
    @DependencyClient
    public struct Client: Sendable {
        @DependencyEndpoint
        public var list: @Sendable () async throws -> Mailgun.IPAddressWarmup.List.Response

        @DependencyEndpoint
        public var get: @Sendable (_ ip: String) async throws -> Mailgun.IPAddressWarmup.IPWarmup

        @DependencyEndpoint
        public var create:
            @Sendable (_ ip: String, _ request: Mailgun.IPAddressWarmup.Create.Request) async throws
                ->
                Mailgun.IPAddressWarmup.Create.Response

        @DependencyEndpoint
        public var delete:
            @Sendable (_ ip: String) async throws -> Mailgun.IPAddressWarmup.Delete.Response
    }
}
