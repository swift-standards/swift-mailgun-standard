//
//  File.swift
//  swift-mailgun
//
//  Created by Coen ten Thije Boonkkamp on 24/12/2024.
//

@_exported import Mailgun_Types_Shared

extension Mailgun {
  public enum Keys {}
}

extension Mailgun.Keys {
  public struct Key: Sendable, Codable, Equatable {
    public let id: String
    public let createdAt: String  // API returns string date
    public let updatedAt: String?
    public let description: String?
    public let isDisabled: Bool
    public let kind: Kind?
    public let role: String?
    public let domainName: String?
    public let requestor: String?
    public let userName: String?
    public let expiresAt: String?

    public init(
      id: String,
      createdAt: String,
      updatedAt: String? = nil,
      description: String? = nil,
      isDisabled: Bool = false,
      kind: Kind? = nil,
      role: String? = nil,
      domainName: String? = nil,
      requestor: String? = nil,
      userName: String? = nil,
      expiresAt: String? = nil
    ) {
      self.id = id
      self.createdAt = createdAt
      self.updatedAt = updatedAt
      self.description = description
      self.isDisabled = isDisabled
      self.kind = kind
      self.role = role
      self.domainName = domainName
      self.requestor = requestor
      self.userName = userName
      self.expiresAt = expiresAt
    }

    private enum CodingKeys: String, CodingKey {
      case id
      case createdAt = "created_at"
      case updatedAt = "updated_at"
      case description
      case isDisabled = "is_disabled"
      case kind
      case role
      case domainName = "domain_name"
      case requestor
      case userName = "user_name"
      case expiresAt = "expires_at"
    }

    public enum Kind: String, Sendable, Codable, Equatable {
      case domain = "domain"
      case user = "user"
      case web = "web"
      case `public` = "public"
    }
  }

  public enum List {
    public struct Response: Sendable, Decodable, Equatable {
      public let items: [Mailgun.Keys.Key]
      public let totalCount: Int

      public init(
        items: [Mailgun.Keys.Key],
        totalCount: Int
      ) {
        self.items = items
        self.totalCount = totalCount
      }

      private enum CodingKeys: String, CodingKey {
        case items
        case totalCount = "total_count"
      }
    }
  }

  public enum Create {
    public struct Request: Sendable, Codable, Equatable {
      public let description: String?
      public let role: String
      public let kind: String?

      public init(
        description: String? = nil,
        role: String = "admin",
        kind: String? = nil
      ) {
        self.description = description
        self.role = role
        self.kind = kind
      }
    }

    public struct Response: Sendable, Decodable, Equatable {
      public let message: String
      public let key: Key

      public init(
        message: String,
        key: Key
      ) {
        self.message = message
        self.key = key
      }

      public struct Key: Sendable, Decodable, Equatable {
        public let id: String
        public let description: String?
        public let kind: String?
        public let role: String?
        public let createdAt: String
        public let updatedAt: String?
        public let secret: String
        public let isDisabled: Bool
        public let domainName: String?
        public let requestor: String?
        public let userName: String?

        public init(
          id: String,
          description: String? = nil,
          kind: String? = nil,
          role: String? = nil,
          createdAt: String,
          updatedAt: String? = nil,
          secret: String,
          isDisabled: Bool = false,
          domainName: String? = nil,
          requestor: String? = nil,
          userName: String? = nil
        ) {
          self.id = id
          self.description = description
          self.kind = kind
          self.role = role
          self.createdAt = createdAt
          self.updatedAt = updatedAt
          self.secret = secret
          self.isDisabled = isDisabled
          self.domainName = domainName
          self.requestor = requestor
          self.userName = userName
        }

        private enum CodingKeys: String, CodingKey {
          case id
          case description
          case kind
          case role
          case createdAt = "created_at"
          case updatedAt = "updated_at"
          case secret
          case isDisabled = "is_disabled"
          case domainName = "domain_name"
          case requestor
          case userName = "user_name"
        }
      }
    }
  }

  public enum Delete {
    public struct Response: Sendable, Decodable, Equatable {
      public let message: String

      public init(message: String) {
        self.message = message
      }
    }
  }

  public enum PublicKey {
    public struct Request: Sendable, Codable, Equatable {
      public let publicKey: String

      public init(publicKey: String) {
        self.publicKey = publicKey
      }

      private enum CodingKeys: String, CodingKey {
        case publicKey = "public_key"
      }
    }

    public struct Response: Sendable, Decodable, Equatable {
      public let message: String

      public init(message: String) {
        self.message = message
      }
    }
  }
}
