//
//  File.swift
//  swift-mailgun
//
//  Created by Coen ten Thije Boonkkamp on 24/12/2024.
//

import DependenciesMacros
import Mailgun_Types_Shared

extension Mailgun.Subaccounts {
  @DependencyClient
  public struct Client: Sendable {
    @DependencyEndpoint
    public var get:
      @Sendable (_ subaccountId: String) async throws -> Mailgun.Subaccounts.Get.Response

    @DependencyEndpoint
    public var list:
      @Sendable (_ request: Mailgun.Subaccounts.List.Request?) async throws ->
        Mailgun.Subaccounts.List.Response

    @DependencyEndpoint
    public var create:
      @Sendable (_ request: Mailgun.Subaccounts.Create.Request) async throws ->
        Mailgun.Subaccounts.Create.Response

    @DependencyEndpoint
    public var delete:
      @Sendable (_ subaccountId: String) async throws -> Mailgun.Subaccounts.Delete.Response

    @DependencyEndpoint
    public var disable:
      @Sendable (_ subaccountId: String, _ request: Mailgun.Subaccounts.Disable.Request?)
        async throws -> Mailgun.Subaccounts.Disable.Response

    @DependencyEndpoint
    public var enable:
      @Sendable (_ subaccountId: String) async throws -> Mailgun.Subaccounts.Enable.Response

    @DependencyEndpoint
    public var getCustomLimit:
      @Sendable (_ subaccountId: String) async throws ->
        Mailgun.Subaccounts.CustomLimit.Get.Response

    @DependencyEndpoint
    public var updateCustomLimit:
      @Sendable (_ subaccountId: String, _ limit: Double) async throws ->
        Mailgun.Subaccounts.CustomLimit.Update.Response

    @DependencyEndpoint
    public var deleteCustomLimit:
      @Sendable (_ subaccountId: String) async throws ->
        Mailgun.Subaccounts.CustomLimit.Delete.Response

    @DependencyEndpoint
    public var updateFeatures:
      @Sendable (_ subaccountId: String, _ request: Mailgun.Subaccounts.Features.Update.Request)
        async throws -> Mailgun.Subaccounts.Features.Update.Response
  }
}
