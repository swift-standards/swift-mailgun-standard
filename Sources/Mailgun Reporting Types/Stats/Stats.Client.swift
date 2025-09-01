//
//  File.swift
//  swift-mailgun
//
//  Created by Coen ten Thije Boonkkamp on 24/12/2024.
//

import DependenciesMacros
import Mailgun_Types_Shared

extension Mailgun.Reporting.Stats {
    @DependencyClient
    public struct Client: Sendable {
        @DependencyEndpoint
        public var total: @Sendable (_ request: Mailgun.Reporting.Stats.Total.Request) async throws -> Mailgun.Reporting.Stats.StatsList

        @DependencyEndpoint
        public var filter: @Sendable (_ request: Mailgun.Reporting.Stats.Filter.Request) async throws -> Mailgun.Reporting.Stats.StatsList

        @DependencyEndpoint
        public var aggregateProviders: @Sendable () async throws -> Mailgun.Reporting.Stats.AggregatesProviders

        @DependencyEndpoint
        public var aggregateDevices: @Sendable () async throws -> Mailgun.Reporting.Stats.AggregatesDevices

        @DependencyEndpoint
        public var aggregateCountries: @Sendable () async throws -> Mailgun.Reporting.Stats.AggregatesCountries
    }
}
