//
//  File.swift
//  swift-mailgun
//
//  Created by Coen ten Thije Boonkkamp on 24/12/2024.
//

@_exported import Mailgun_Types_Shared

extension Mailgun {
  public enum IPPools {}
}

extension Mailgun.IPPools {
  public struct IPPool: Sendable, Codable, Equatable {
    public let poolId: String
    public let name: String
    public let description: String
    public let ips: [String]
    public let isLinked: Bool
    public let linkedDomains: [String]?

    public init(
      poolId: String,
      name: String,
      description: String,
      ips: [String],
      isLinked: Bool,
      linkedDomains: [String]? = nil
    ) {
      self.poolId = poolId
      self.name = name
      self.description = description
      self.ips = ips
      self.isLinked = isLinked
      self.linkedDomains = linkedDomains
    }

    private enum CodingKeys: String, CodingKey {
      case poolId = "pool_id"
      case name
      case description
      case ips
      case isLinked = "is_linked"
      case linkedDomains = "linked_domains"
    }
  }
}

// MARK: - List Operation

extension Mailgun.IPPools {
  public enum List {}
}

extension Mailgun.IPPools.List {
  public struct Response: Sendable, Decodable, Equatable {
    public let ipPools: [Mailgun.IPPools.IPPool]
    public let message: String

    public init(
      ipPools: [Mailgun.IPPools.IPPool],
      message: String
    ) {
      self.ipPools = ipPools
      self.message = message
    }

    private enum CodingKeys: String, CodingKey {
      case ipPools = "ip_pools"
      case message
    }
  }
}

// MARK: - Create Operation

extension Mailgun.IPPools {
  public enum Create {}
}

extension Mailgun.IPPools.Create {
  public struct Request: Sendable, Codable, Equatable {
    public let name: String
    public let description: String
    public let ips: [String]

    public init(
      name: String,
      description: String,
      ips: [String]
    ) {
      self.name = name
      self.description = description
      self.ips = ips
    }
  }

  public struct Response: Sendable, Decodable, Equatable {
    public let poolId: String
    public let message: String

    public init(
      poolId: String,
      message: String
    ) {
      self.poolId = poolId
      self.message = message
    }

    private enum CodingKeys: String, CodingKey {
      case poolId = "pool_id"
      case message
    }
  }
}

// MARK: - Update Operation

extension Mailgun.IPPools {
  public enum Update {}
}

extension Mailgun.IPPools.Update {
  public struct Request: Sendable, Codable, Equatable {
    public let name: String?
    public let description: String?
    public let addIps: [String]?
    public let removeIps: [String]?

    public init(
      name: String? = nil,
      description: String? = nil,
      addIps: [String]? = nil,
      removeIps: [String]? = nil
    ) {
      self.name = name
      self.description = description
      self.addIps = addIps
      self.removeIps = removeIps
    }

    private enum CodingKeys: String, CodingKey {
      case name
      case description
      case addIps = "add_ips"
      case removeIps = "remove_ips"
    }
  }

  public struct Response: Sendable, Decodable, Equatable {
    public let message: String

    public init(message: String) {
      self.message = message
    }
  }
}

// MARK: - Delete Operation

extension Mailgun.IPPools {
  public enum Delete {}
}

extension Mailgun.IPPools.Delete {
  public struct Request: Sendable, Codable, Equatable {
    public let ip: String?
    public let poolId: String?

    public init(
      ip: String? = nil,
      poolId: String? = nil
    ) {
      self.ip = ip
      self.poolId = poolId
    }

    private enum CodingKeys: String, CodingKey {
      case ip
      case poolId = "pool_id"
    }
  }

  public struct Response: Sendable, Decodable, Equatable {
    public let message: String

    public init(message: String) {
      self.message = message
    }
  }
}

// MARK: - Domains List Operation

extension Mailgun.IPPools {
  public enum DomainsList {}
}

extension Mailgun.IPPools.DomainsList {
  public struct Response: Sendable, Decodable, Equatable {
    public let domains: [String]
    public let message: String

    public init(
      domains: [String],
      message: String
    ) {
      self.domains = domains
      self.message = message
    }
  }
}
