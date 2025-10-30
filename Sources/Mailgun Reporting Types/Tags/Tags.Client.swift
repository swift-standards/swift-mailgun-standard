//
//  Tags.Client.swift
//  swift-mailgun
//
//  Created by Claude on 31/12/2024.
//

import Dependencies
import DependenciesMacros
import Mailgun_Types_Shared

extension Mailgun.Reporting.Tags {
  @DependencyClient
  public struct Client: Sendable {
    @DependencyEndpoint
    public var list:
      @Sendable (_ request: Mailgun.Reporting.Tags.List.Request?) async throws ->
        Mailgun.Reporting.Tags.List.Response

    @DependencyEndpoint
    public var get: @Sendable (_ tag: String) async throws -> Mailgun.Reporting.Tags.Get.Response

    @DependencyEndpoint
    public var update:
      @Sendable (_ tag: String, _ request: Mailgun.Reporting.Tags.Update.Request) async throws ->
        Mailgun.Reporting.Tags.Update.Response

    @DependencyEndpoint
    public var delete:
      @Sendable (_ tag: String) async throws -> Mailgun.Reporting.Tags.Delete.Response

    @DependencyEndpoint
    public var stats:
      @Sendable (_ tag: String, _ request: Mailgun.Reporting.Tags.Stats.Request) async throws ->
        Mailgun.Reporting.Tags.Stats.Response

    @DependencyEndpoint
    public var aggregates:
      @Sendable (_ tag: String, _ request: Mailgun.Reporting.Tags.Aggregates.Request) async throws
        -> Mailgun.Reporting.Tags.Aggregates.Response

    @DependencyEndpoint
    public var limits: @Sendable () async throws -> Mailgun.Reporting.Tags.Limits.Response
  }
}
