//
//  DynamicIPPools.swift
//  swift-mailgun-types
//
//  Created by Assistant on 05/08/2025.
//

@_exported import Mailgun_Types_Shared

extension Mailgun {
  public enum DynamicIPPools {}
}

extension Mailgun.DynamicIPPools {
  public struct HistoryRecord: Sendable, Codable, Equatable {
    public let domain: String
    public let timestamp: Date
    public let movedFrom: String?
    public let movedTo: String
    public let reason: String?
    public let accountId: String?

    public init(
      domain: String,
      timestamp: Date,
      movedFrom: String?,
      movedTo: String,
      reason: String? = nil,
      accountId: String? = nil
    ) {
      self.domain = domain
      self.timestamp = timestamp
      self.movedFrom = movedFrom
      self.movedTo = movedTo
      self.reason = reason
      self.accountId = accountId
    }

    private enum CodingKeys: String, CodingKey {
      case domain
      case timestamp
      case movedFrom = "moved_from"
      case movedTo = "moved_to"
      case reason
      case accountId = "account_id"
    }
  }
}

// MARK: - History List Operation

extension Mailgun.DynamicIPPools {
  public enum HistoryList {}
}

extension Mailgun.DynamicIPPools.HistoryList {
  public struct Request: Sendable, Codable, Equatable {
    public let limit: Int?
    public let includeSubaccounts: Bool?
    public let domain: String?
    public let before: String?
    public let after: String?
    public let movedTo: String?
    public let movedFrom: String?

    public init(
      limit: Int? = nil,
      includeSubaccounts: Bool? = nil,
      domain: String? = nil,
      before: String? = nil,
      after: String? = nil,
      movedTo: String? = nil,
      movedFrom: String? = nil
    ) {
      self.limit = limit
      self.includeSubaccounts = includeSubaccounts
      self.domain = domain
      self.before = before
      self.after = after
      self.movedTo = movedTo
      self.movedFrom = movedFrom
    }

    private enum CodingKeys: String, CodingKey {
      case limit = "Limit"
      case includeSubaccounts = "include_subaccounts"
      case domain
      case before
      case after
      case movedTo = "moved_to"
      case movedFrom = "moved_from"
    }
  }
}

extension Mailgun.DynamicIPPools.HistoryList {
  public struct Response: Sendable, Decodable, Equatable {
    public let items: [Mailgun.DynamicIPPools.HistoryRecord]
    public let paging: PagingInfo?

    public init(
      items: [Mailgun.DynamicIPPools.HistoryRecord],
      paging: PagingInfo? = nil
    ) {
      self.items = items
      self.paging = paging
    }

    public struct PagingInfo: Sendable, Decodable, Equatable {
      public let next: String?
      public let previous: String?
      public let first: String?
      public let last: String?

      public init(
        next: String? = nil,
        previous: String? = nil,
        first: String? = nil,
        last: String? = nil
      ) {
        self.next = next
        self.previous = previous
        self.first = first
        self.last = last
      }
    }
  }
}

// MARK: - Remove Override Operation

extension Mailgun.DynamicIPPools {
  public enum RemoveOverride {}
}

extension Mailgun.DynamicIPPools.RemoveOverride {
  public struct Response: Sendable, Decodable, Equatable {
    public let message: String

    public init(message: String) {
      self.message = message
    }
  }
}
