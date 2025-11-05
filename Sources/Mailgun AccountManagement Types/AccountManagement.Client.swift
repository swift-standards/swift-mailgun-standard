//
//  File.swift
//  swift-mailgun
//
//  Created by Coen ten Thije Boonkkamp on 24/12/2024.
//

import DependenciesMacros
import Mailgun_Types_Shared

extension Mailgun.AccountManagement {
    @DependencyClient
    public struct Client: Sendable {
        @DependencyEndpoint
        public var updateAccount:
            @Sendable (_ request: Mailgun.AccountManagement.Update.Request) async throws ->
                Mailgun.AccountManagement.Update.Response

        @DependencyEndpoint
        public var getHttpSigningKey:
            @Sendable () async throws -> Mailgun.AccountManagement.HttpSigningKey.Get.Response

        @DependencyEndpoint
        public var regenerateHttpSigningKey:
            @Sendable () async throws ->
                Mailgun.AccountManagement.HttpSigningKey.Regenerate.Response

        @DependencyEndpoint
        public var getSandboxAuthRecipients:
            @Sendable () async throws ->
                Mailgun.AccountManagement.Sandbox.Auth.Recipients.List.Response

        @DependencyEndpoint
        public var addSandboxAuthRecipient:
            @Sendable (_ request: Mailgun.AccountManagement.Sandbox.Auth.Recipients.Add.Request)
                async throws -> Mailgun.AccountManagement.Sandbox.Auth.Recipients.Add.Response

        @DependencyEndpoint
        public var deleteSandboxAuthRecipient:
            @Sendable (_ email: EmailAddress) async throws ->
                Mailgun.AccountManagement.Sandbox.Auth.Recipients.Delete.Response

        @DependencyEndpoint
        public var resendActivationEmail:
            @Sendable () async throws -> Mailgun.AccountManagement.ResendActivationEmail.Response

        @DependencyEndpoint
        public var getSAMLOrganization:
            @Sendable () async throws -> Mailgun.AccountManagement.SAML.Organization.Get.Response

        @DependencyEndpoint
        public var addSAMLOrganization:
            @Sendable (_ request: Mailgun.AccountManagement.SAML.Organization.Add.Request)
                async throws ->
                Mailgun.AccountManagement.SAML.Organization.Add.Response
    }
}
