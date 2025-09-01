//
//  File.swift
//  swift-mailgun
//
//  Created by Coen ten Thije Boonkkamp on 24/12/2024.
//

import DependenciesMacros
import Mailgun_Types_Shared

extension Mailgun.Webhooks {
    @DependencyClient
    public struct Client: Sendable {
        @DependencyEndpoint
        public var list: @Sendable () async throws -> Mailgun.Webhooks.List.Response

        @DependencyEndpoint
        public var get: @Sendable (_ webhookName: WebhookType) async throws -> Mailgun.Webhooks.Get.Response

        @DependencyEndpoint
        public var create: @Sendable (_ request: Create.Request) async throws -> Mailgun.Webhooks.Create.Response

        @DependencyEndpoint
        public var update: @Sendable (_ webhookName: WebhookType, _ request: Update.Request) async throws -> Mailgun.Webhooks.Update.Response

        @DependencyEndpoint
        public var delete: @Sendable (_ webhookName: WebhookType) async throws -> Mailgun.Webhooks.Delete.Response
    }
}
