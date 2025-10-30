//
//  File.swift
//  swift-mailgun
//
//  Created by Coen ten Thije Boonkkamp on 24/12/2024.
//

import Mailgun_Types_Shared
import URLRouting

extension Mailgun.Domains {
  @CasePathable
  @dynamicMemberLookup
  public enum API: Equatable, Sendable {
    case domain(Domains.API)
    case dkimSecurity(DKIM_Security.API)
    case dkimKeys(DomainKeys.API)
    case dkimTracking(Domains.Tracking.API)
  }
}

extension Mailgun.Domains.API {
  public struct Router: ParserPrinter, Sendable {
    public init() {}

    public var body: some URLRouting.Router<Mailgun.Domains.API> {
      OneOf {
        URLRouting.Route(.case(Mailgun.Domains.API.domain)) {
          Mailgun.Domains.Domains.API.Router()
        }
        URLRouting.Route(.case(Mailgun.Domains.API.dkimSecurity)) {
          Mailgun.Domains.DKIM_Security.API.Router()
        }
        URLRouting.Route(.case(Mailgun.Domains.API.dkimKeys)) {
          Mailgun.Domains.DomainKeys.API.Router()
        }
        URLRouting.Route(.case(Mailgun.Domains.API.dkimTracking)) {
          Mailgun.Domains.Domains.Tracking.API.Router()
        }
      }
    }
  }
}
