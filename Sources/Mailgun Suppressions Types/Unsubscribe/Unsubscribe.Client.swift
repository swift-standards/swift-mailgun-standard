//
//  File.swift
//  swift-mailgun
//
//  Created by Coen ten Thije Boonkkamp on 24/12/2024.
//

import DependenciesMacros
import Mailgun_Types_Shared

extension Mailgun.Suppressions.Unsubscribe {
  @DependencyClient
  public struct Client: Sendable {
    @DependencyEndpoint
    public var importList:
      @Sendable (_ request: Foundation.Data) async throws ->
        Mailgun.Suppressions.Unsubscribe.Import.Response

    @DependencyEndpoint
    public var get:
      @Sendable (_ address: EmailAddress) async throws ->
        Mailgun.Suppressions.Unsubscribe.Get.Response

    @DependencyEndpoint
    public var delete:
      @Sendable (_ address: EmailAddress) async throws ->
        Mailgun.Suppressions.Unsubscribe.Delete.Response

    @DependencyEndpoint
    public var list:
      @Sendable (_ request: Mailgun.Suppressions.Unsubscribe.List.Request?) async throws ->
        Mailgun.Suppressions.Unsubscribe.List.Response

    @DependencyEndpoint
    public var create:
      @Sendable (_ request: Mailgun.Suppressions.Unsubscribe.Create.Request) async throws ->
        Mailgun.Suppressions.Unsubscribe.Create.Response

    @DependencyEndpoint
    public var deleteAll:
      @Sendable () async throws -> Mailgun.Suppressions.Unsubscribe.DeleteAll.Response
  }
}
