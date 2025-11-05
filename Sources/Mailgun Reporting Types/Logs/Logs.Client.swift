//
//  Logs.Client.swift
//  swift-mailgun-types
//
//  Created by Coen ten Thije Boonkkamp on 31/12/2024.
//

import Dependencies
import DependenciesMacros
import Foundation
import Mailgun_Types_Shared

extension Mailgun.Reporting.Logs {
    @DependencyClient
    public struct Client: Sendable {
        @DependencyEndpoint
        public var analytics:
            @Sendable (_ request: Analytics.Request) async throws -> Analytics.Response
    }
}
