//
//  File.swift
//  swift-mailgun
//
//  Created by Coen ten Thije Boonkkamp on 24/12/2024.
//

@_exported import Mailgun_Types_Shared

extension Mailgun.Domains {
  public enum Domains {}
}

// MARK: - Core Domain Types

extension Mailgun.Domains.Domains {
  public struct DomainInfo: Sendable, Codable, Equatable {
    public let id: String?
    public let name: String
    public let smtpLogin: String?
    public let smtpPassword: String?
    public let spamAction: SpamAction
    public let state: State
    public let type: DomainType
    public let wildcard: Bool
    public let createdAt: String?
    public let skipVerification: Bool?
    public let isDisabled: Bool?
    public let webScheme: String?
    public let webPrefix: String?
    public let requireTls: Bool?
    public let requireTlsConnection: Bool?
    public let useAutomaticSenderSecurity: Bool?
    public let encryptIncomingMessage: Bool?
    public let messageTtl: Int?

    public init(
      id: String? = nil,
      name: String,
      smtpLogin: String? = nil,
      smtpPassword: String? = nil,
      spamAction: SpamAction,
      state: State,
      type: DomainType,
      wildcard: Bool,
      createdAt: String? = nil,
      skipVerification: Bool? = nil,
      isDisabled: Bool? = nil,
      webScheme: String? = nil,
      webPrefix: String? = nil,
      requireTls: Bool? = nil,
      requireTlsConnection: Bool? = nil,
      useAutomaticSenderSecurity: Bool? = nil,
      encryptIncomingMessage: Bool? = nil,
      messageTtl: Int? = nil
    ) {
      self.id = id
      self.name = name
      self.smtpLogin = smtpLogin
      self.smtpPassword = smtpPassword
      self.spamAction = spamAction
      self.state = state
      self.type = type
      self.wildcard = wildcard
      self.createdAt = createdAt
      self.skipVerification = skipVerification
      self.isDisabled = isDisabled
      self.webScheme = webScheme
      self.webPrefix = webPrefix
      self.requireTls = requireTls
      self.requireTlsConnection = requireTlsConnection
      self.useAutomaticSenderSecurity = useAutomaticSenderSecurity
      self.encryptIncomingMessage = encryptIncomingMessage
      self.messageTtl = messageTtl
    }

    private enum CodingKeys: String, CodingKey {
      case id
      case name
      case smtpLogin = "smtp_login"
      case smtpPassword = "smtp_password"
      case spamAction = "spam_action"
      case state
      case type
      case wildcard
      case createdAt = "created_at"
      case skipVerification = "skip_verification"
      case isDisabled = "is_disabled"
      case webScheme = "web_scheme"
      case webPrefix = "web_prefix"
      case requireTls = "require_tls"
      case requireTlsConnection = "require_tls_connection"
      case useAutomaticSenderSecurity = "use_automatic_sender_security"
      case encryptIncomingMessage = "encrypt_incoming_message"
      case messageTtl = "message_ttl"
    }
  }

  public enum SpamAction: String, Sendable, Codable, Equatable {
    case disabled = "disabled"
    case block = "block"
    case tag = "tag"
  }

  public enum State: String, Sendable, Codable, Equatable {
    case active = "active"
    case unverified = "unverified"
    case disabled = "disabled"
  }

  public enum DomainType: String, Sendable, Codable, Equatable {
    case sandbox = "sandbox"
    case custom = "custom"
  }

  public struct DnsRecord: Sendable, Codable, Equatable {
    public let recordType: String
    public let valid: String
    public let name: String
    public let value: String
    public let priority: String?

    public init(
      recordType: String,
      valid: String,
      name: String,
      value: String,
      priority: String? = nil
    ) {
      self.recordType = recordType
      self.valid = valid
      self.name = name
      self.value = value
      self.priority = priority
    }

    private enum CodingKeys: String, CodingKey {
      case recordType = "record_type"
      case valid
      case name
      case value
      case priority
    }
  }
}

// MARK: - List Domains

extension Mailgun.Domains.Domains {
  public enum List {}
}

extension Mailgun.Domains.Domains.List {
  public struct Request: Sendable, Codable, Equatable {
    public let authority: String?
    public let state: Mailgun.Domains.Domains.State?
    public let limit: Int?
    public let skip: Int?

    public init(
      authority: String? = nil,
      state: Mailgun.Domains.Domains.State? = nil,
      limit: Int? = nil,
      skip: Int? = nil
    ) {
      self.authority = authority
      self.state = state
      self.limit = limit
      self.skip = skip
    }
  }

  public struct Response: Sendable, Codable, Equatable {
    public let items: [Mailgun.Domains.Domains.DomainInfo]
    public let totalCount: Int

    public init(
      items: [Mailgun.Domains.Domains.DomainInfo]? = nil,
      totalCount: Int
    ) {
      self.items = items ?? []
      self.totalCount = totalCount
    }

    public init(from decoder: Decoder) throws {
      let container = try decoder.container(keyedBy: CodingKeys.self)
      self.items =
        try container.decodeIfPresent([Mailgun.Domains.Domains.DomainInfo].self, forKey: .items)
        ?? []
      self.totalCount = try container.decode(Int.self, forKey: .totalCount)
    }

    private enum CodingKeys: String, CodingKey {
      case items
      case totalCount = "total_count"
    }
  }
}

// MARK: - Create Domain

extension Mailgun.Domains.Domains {
  public enum Create {}
}

extension Mailgun.Domains.Domains.Create {
  public struct Request: Sendable, Codable, Equatable {
    public let name: String
    public let smtpPassword: String?
    public let spamAction: Mailgun.Domains.Domains.SpamAction?
    public let wildcard: Bool?
    public let forceDkimAuthority: Bool?
    public let dkimKeySize: Int?
    public let ips: String?
    public let poolId: String?
    public let webScheme: String?

    public init(
      name: String,
      smtpPassword: String? = nil,
      spamAction: Mailgun.Domains.Domains.SpamAction? = nil,
      wildcard: Bool? = nil,
      forceDkimAuthority: Bool? = nil,
      dkimKeySize: Int? = nil,
      ips: String? = nil,
      poolId: String? = nil,
      webScheme: String? = nil
    ) {
      self.name = name
      self.smtpPassword = smtpPassword
      self.spamAction = spamAction
      self.wildcard = wildcard
      self.forceDkimAuthority = forceDkimAuthority
      self.dkimKeySize = dkimKeySize
      self.ips = ips
      self.poolId = poolId
      self.webScheme = webScheme
    }

    private enum CodingKeys: String, CodingKey {
      case name
      case smtpPassword = "smtp_password"
      case spamAction = "spam_action"
      case wildcard
      case forceDkimAuthority = "force_dkim_authority"
      case dkimKeySize = "dkim_key_size"
      case ips
      case poolId = "pool_id"
      case webScheme = "web_scheme"
    }
  }

  public struct Response: Sendable, Codable, Equatable {
    public let domain: Mailgun.Domains.Domains.DomainInfo
    public let receivingDnsRecords: [Mailgun.Domains.Domains.DnsRecord]?
    public let sendingDnsRecords: [Mailgun.Domains.Domains.DnsRecord]?
    public let message: String

    public init(
      domain: Mailgun.Domains.Domains.DomainInfo,
      receivingDnsRecords: [Mailgun.Domains.Domains.DnsRecord]? = nil,
      sendingDnsRecords: [Mailgun.Domains.Domains.DnsRecord]? = nil,
      message: String
    ) {
      self.domain = domain
      self.receivingDnsRecords = receivingDnsRecords
      self.sendingDnsRecords = sendingDnsRecords
      self.message = message
    }

    private enum CodingKeys: String, CodingKey {
      case domain
      case receivingDnsRecords = "receiving_dns_records"
      case sendingDnsRecords = "sending_dns_records"
      case message
    }
  }
}

// MARK: - Get Domain

extension Mailgun.Domains.Domains {
  public enum Get {}
}

extension Mailgun.Domains.Domains.Get {
  public struct Response: Sendable, Codable, Equatable {
    public let domain: Mailgun.Domains.Domains.DomainInfo
    public let receivingDnsRecords: [Mailgun.Domains.Domains.DnsRecord]?
    public let sendingDnsRecords: [Mailgun.Domains.Domains.DnsRecord]?

    public init(
      domain: Mailgun.Domains.Domains.DomainInfo,
      receivingDnsRecords: [Mailgun.Domains.Domains.DnsRecord]? = nil,
      sendingDnsRecords: [Mailgun.Domains.Domains.DnsRecord]? = nil
    ) {
      self.domain = domain
      self.receivingDnsRecords = receivingDnsRecords
      self.sendingDnsRecords = sendingDnsRecords
    }

    private enum CodingKeys: String, CodingKey {
      case domain
      case receivingDnsRecords = "receiving_dns_records"
      case sendingDnsRecords = "sending_dns_records"
    }
  }
}

// MARK: - Update Domain

extension Mailgun.Domains.Domains {
  public enum Update {}
}

extension Mailgun.Domains.Domains.Update {
  public struct Request: Sendable, Codable, Equatable {
    public let spamAction: Mailgun.Domains.Domains.SpamAction?
    public let webScheme: String?
    public let wildcard: Bool?

    public init(
      spamAction: Mailgun.Domains.Domains.SpamAction? = nil,
      webScheme: String? = nil,
      wildcard: Bool? = nil
    ) {
      self.spamAction = spamAction
      self.webScheme = webScheme
      self.wildcard = wildcard
    }

    private enum CodingKeys: String, CodingKey {
      case spamAction = "spam_action"
      case webScheme = "web_scheme"
      case wildcard
    }
  }

  public struct Response: Sendable, Codable, Equatable {
    public let domain: Mailgun.Domains.Domains.DomainInfo
    public let receivingDnsRecords: [Mailgun.Domains.Domains.DnsRecord]?
    public let sendingDnsRecords: [Mailgun.Domains.Domains.DnsRecord]?
    public let message: String

    public init(
      domain: Mailgun.Domains.Domains.DomainInfo,
      receivingDnsRecords: [Mailgun.Domains.Domains.DnsRecord]? = nil,
      sendingDnsRecords: [Mailgun.Domains.Domains.DnsRecord]? = nil,
      message: String
    ) {
      self.domain = domain
      self.receivingDnsRecords = receivingDnsRecords
      self.sendingDnsRecords = sendingDnsRecords
      self.message = message
    }

    private enum CodingKeys: String, CodingKey {
      case domain
      case receivingDnsRecords = "receiving_dns_records"
      case sendingDnsRecords = "sending_dns_records"
      case message
    }
  }
}

// MARK: - Delete Domain

extension Mailgun.Domains.Domains {
  public enum Delete {}
}

extension Mailgun.Domains.Domains.Delete {
  public struct Response: Sendable, Codable, Equatable {
    public let message: String

    public init(message: String) {
      self.message = message
    }
  }
}

// MARK: - Verify Domain

extension Mailgun.Domains.Domains {
  public enum Verify {}
}

extension Mailgun.Domains.Domains.Verify {
  public struct Response: Sendable, Codable, Equatable {
    public let domain: Mailgun.Domains.Domains.DomainInfo
    public let receivingDnsRecords: [Mailgun.Domains.Domains.DnsRecord]?
    public let sendingDnsRecords: [Mailgun.Domains.Domains.DnsRecord]?
    public let message: String

    public init(
      domain: Mailgun.Domains.Domains.DomainInfo,
      receivingDnsRecords: [Mailgun.Domains.Domains.DnsRecord]? = nil,
      sendingDnsRecords: [Mailgun.Domains.Domains.DnsRecord]? = nil,
      message: String
    ) {
      self.domain = domain
      self.receivingDnsRecords = receivingDnsRecords
      self.sendingDnsRecords = sendingDnsRecords
      self.message = message
    }

    private enum CodingKeys: String, CodingKey {
      case domain
      case receivingDnsRecords = "receiving_dns_records"
      case sendingDnsRecords = "sending_dns_records"
      case message
    }
  }
}
