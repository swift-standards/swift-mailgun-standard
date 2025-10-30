//
//  DynamicIPPools Client.swift
//  swift-mailgun-types
//
//  Created by Assistant on 05/08/2025.
//

import DependenciesMacros
@_exported import Mailgun_Types_Shared

extension Mailgun.DynamicIPPools {
  @DependencyClient
  public struct Client: Sendable {
    @DependencyEndpoint
    public var listHistory:
      @Sendable (_ request: Mailgun.DynamicIPPools.HistoryList.Request) async throws ->
        Mailgun.DynamicIPPools.HistoryList.Response

    @DependencyEndpoint
    public var removeOverride:
      @Sendable (_ domain: String) async throws -> Mailgun.DynamicIPPools.RemoveOverride.Response
  }
}
