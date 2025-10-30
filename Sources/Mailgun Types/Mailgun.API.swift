//
//  File.swift
//  swift-mailgun
//
//  Created by Coen ten Thije Boonkkamp on 20/12/2024.
//

import Mailgun_AccountManagement_Types
import Mailgun_Credentials_Types
import Mailgun_CustomMessageLimit_Types
import Mailgun_Domains_Types
import Mailgun_IPAllowlist_Types
import Mailgun_IPPools_Types
import Mailgun_IPs_Types
import Mailgun_Keys_Types
import Mailgun_Lists_Types
import Mailgun_Messages_Types
import Mailgun_Reporting_Types
import Mailgun_Routes_Types
import Mailgun_Subaccounts_Types
import Mailgun_Suppressions_Types
import Mailgun_Templates_Types
import Mailgun_Types_Shared
import Mailgun_Users_Types
import Mailgun_Webhooks_Types
import URLRouting

extension Mailgun {
  @CasePathable
  @dynamicMemberLookup
  public enum API: Equatable, Sendable {
    case messages(Mailgun.Messages.API)
    case lists(Mailgun.Lists.API)
    case events(Mailgun.Reporting.Events.API)
    case suppressions(Mailgun.Suppressions.API)
    case webhooks(Mailgun.Webhooks.API)
    case domains(Mailgun.Domains.API)
    case templates(Mailgun.Templates.API)
    case routes(Mailgun.Routes.API)
    case ips(Mailgun.IPs.API)
    case ipPools(Mailgun.IPPools.API)
    case ipAllowlist(Mailgun.IPAllowlist.API)
    case keys(Mailgun.Keys.API)
    case users(Mailgun.Users.API)
    case subaccounts(Mailgun.Subaccounts.API)
    case credentials(Mailgun.Credentials.API)
    case customMessageLimit(Mailgun.CustomMessageLimit.API)
    case accountManagement(Mailgun.AccountManagement.API)
    case reporting(Mailgun.Reporting.API)
  }
}

extension Mailgun.API {
  public struct Router: ParserPrinter, Sendable {

    public init() {}

    public var body: some URLRouting.Router<Mailgun.API> {
      OneOf {
        URLRouting.Route(.case(Mailgun.API.messages)) {
          Mailgun.Messages.API.Router()
        }

        URLRouting.Route(.case(Mailgun.API.lists)) {
          Mailgun.Lists.API.Router()
        }

        URLRouting.Route(.case(Mailgun.API.events)) {
          Mailgun.Reporting.Events.API.Router()
        }

        URLRouting.Route(.case(Mailgun.API.suppressions)) {
          Mailgun.Suppressions.API.Router()
        }

        URLRouting.Route(.case(Mailgun.API.webhooks)) {
          Mailgun.Webhooks.API.Router()
        }

        URLRouting.Route(.case(Mailgun.API.domains)) {
          Mailgun.Domains.API.Router()
        }

        URLRouting.Route(.case(Mailgun.API.templates)) {
          Mailgun.Templates.API.Router()
        }

        URLRouting.Route(.case(Mailgun.API.routes)) {
          Mailgun.Routes.API.Router()
        }

        URLRouting.Route(.case(Mailgun.API.ips)) {
          Mailgun.IPs.API.Router()
        }

        URLRouting.Route(.case(Mailgun.API.ipPools)) {
          Mailgun.IPPools.API.Router()
        }

        URLRouting.Route(.case(Mailgun.API.ipAllowlist)) {
          Mailgun.IPAllowlist.API.Router()
        }

        URLRouting.Route(.case(Mailgun.API.keys)) {
          Mailgun.Keys.API.Router()
        }

        URLRouting.Route(.case(Mailgun.API.users)) {
          Mailgun.Users.API.Router()
        }

        URLRouting.Route(.case(Mailgun.API.subaccounts)) {
          Mailgun.Subaccounts.API.Router()
        }

        URLRouting.Route(.case(Mailgun.API.credentials)) {
          Mailgun.Credentials.API.Router()
        }

        URLRouting.Route(.case(Mailgun.API.customMessageLimit)) {
          Mailgun.CustomMessageLimit.API.Router()
        }

        URLRouting.Route(.case(Mailgun.API.accountManagement)) {
          Mailgun.AccountManagement.API.Router()
        }

        URLRouting.Route(.case(Mailgun.API.reporting)) {
          Mailgun.Reporting.API.Router()
        }
      }
    }
  }
}
