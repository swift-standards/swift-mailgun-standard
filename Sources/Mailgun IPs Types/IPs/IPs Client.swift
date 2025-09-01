//
//  File.swift
//  swift-mailgun
//
//  Created by Coen ten Thije Boonkkamp on 24/12/2024.
//

import Dependencies
import DependenciesMacros
import Mailgun_Types_Shared

extension Mailgun.IPs {
    @DependencyClient
    public struct Client: Sendable {
        @DependencyEndpoint
        public var list: @Sendable () async throws -> Mailgun.IPs.List.Response

        @DependencyEndpoint
        public var get: @Sendable (_ ip: String) async throws -> Mailgun.IPs.IP

        @DependencyEndpoint
        public var listDomains: @Sendable (_ ip: String) async throws -> Mailgun.IPs.DomainList.Response

        @DependencyEndpoint
        public var assignDomain: @Sendable (_ ip: String, _ request: Mailgun.IPs.AssignDomain.Request) async throws -> Mailgun.IPs.AssignDomain.Response

        @DependencyEndpoint
        public var unassignDomain: @Sendable (_ ip: String, _ domain: String) async throws -> Mailgun.IPs.Delete.Response

        @DependencyEndpoint
        public var assignIPBand: @Sendable (_ ip: String, _ request: Mailgun.IPs.IPBand.Request) async throws -> Mailgun.IPs.IPBand.Response

        @DependencyEndpoint
        public var requestNew: @Sendable (_ request: Mailgun.IPs.RequestNew.Request) async throws -> Mailgun.IPs.RequestNew.Response

        @DependencyEndpoint
        public var getRequestedIPs: @Sendable () async throws -> Mailgun.IPs.RequestNew.Response

        @DependencyEndpoint
        public var deleteDomainIP: @Sendable (_ domain: String, _ ip: String) async throws -> Mailgun.IPs.Delete.Response

        @DependencyEndpoint
        public var deleteDomainPool: @Sendable (_ domain: String, _ ip: String) async throws -> Mailgun.IPs.Delete.Response
    }
}
