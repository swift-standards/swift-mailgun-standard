//
//  File.swift
//  swift-mailgun
//
//  Created by Coen ten Thije Boonkkamp on 24/12/2024.
//

import Dependencies
import DependenciesMacros
import Mailgun_Types_Shared

extension Mailgun.Reporting.Metrics {
    @DependencyClient
    public struct Client: Sendable {
        @DependencyEndpoint
        public var getAccountMetrics: @Sendable (_ request: Mailgun.Reporting.Metrics.GetAccountMetrics.Request) async throws -> Mailgun.Reporting.Metrics.GetAccountMetrics.Response

        @DependencyEndpoint
        public var getAccountUsageMetrics: @Sendable (_ request: Mailgun.Reporting.Metrics.GetAccountUsageMetrics.Request) async throws -> Mailgun.Reporting.Metrics.GetAccountUsageMetrics.Response
    }
}
