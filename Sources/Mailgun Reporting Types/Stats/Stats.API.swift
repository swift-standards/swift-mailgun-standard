//
//  File.swift
//  swift-mailgun
//
//  Created by Coen ten Thije Boonkkamp on 24/12/2024.
//

import Mailgun_Types_Shared

extension Mailgun.Reporting.Stats {
  @CasePathable
  @dynamicMemberLookup
  public enum API: Equatable, Sendable {
    case total(request: Mailgun.Reporting.Stats.Total.Request)
    case filter(request: Mailgun.Reporting.Stats.Filter.Request)
    case aggregateProviders(domain: Domain)
    case aggregateDevices(domain: Domain)
    case aggregateCountries(domain: Domain)
  }
}

extension Mailgun.Reporting.Stats.API {
  public struct Router: ParserPrinter, Sendable {
    public init() {}

    public var body: some URLRouting.Router<Mailgun.Reporting.Stats.API> {
      OneOf {
        URLRouting.Route(.case(Mailgun.Reporting.Stats.API.total)) {
          Method.get
          Path { "v3" }
          Path.stats
          Path.total
          Parse(.memberwise(Mailgun.Reporting.Stats.Total.Request.init)) {
            URLRouting.Query {
              Field("event") { Parse(.string) }
              Optionally {
                Field("start") { Parse(.string) }
              }
              Optionally {
                Field("end") { Parse(.string) }
              }
              Optionally {
                Field("resolution") { Parse(.string) }
              }
              Optionally {
                Field("duration") { Parse(.string) }
              }
            }
          }
        }

        URLRouting.Route(.case(Mailgun.Reporting.Stats.API.filter)) {
          Method.get
          Path { "v3" }
          Path.stats
          Path { "filter" }
          Parse(.memberwise(Mailgun.Reporting.Stats.Filter.Request.init)) {
            URLRouting.Query {
              Field("event") { Parse(.string) }
              Optionally {
                Field("start") { Parse(.string) }
              }
              Optionally {
                Field("end") { Parse(.string) }
              }
              Optionally {
                Field("resolution") { Parse(.string) }
              }
              Optionally {
                Field("duration") { Parse(.string) }
              }
              Optionally {
                Field("filter") { Parse(.string) }
              }
              Optionally {
                Field("group") { Parse(.string) }
              }
            }
          }
        }

        URLRouting.Route(.case(Mailgun.Reporting.Stats.API.aggregateProviders)) {
          Method.get
          Path { "v3" }
          Path { Parse(.string.representing(Domain.self)) }
          Path.aggregates
          Path.providers
        }

        URLRouting.Route(.case(Mailgun.Reporting.Stats.API.aggregateDevices)) {
          Method.get
          Path { "v3" }
          Path { Parse(.string.representing(Domain.self)) }
          Path.aggregates
          Path.devices
        }

        URLRouting.Route(.case(Mailgun.Reporting.Stats.API.aggregateCountries)) {
          Method.get
          Path { "v3" }
          Path { Parse(.string.representing(Domain.self)) }
          Path.aggregates
          Path.countries
        }
      }
    }
  }
}

extension Path<PathBuilder.Component<String>> {
  public static let stats = Path {
    "stats"
  }

  public static let total = Path {
    "total"
  }

  public static let filter = Path {
    "filter"
  }

  public static let aggregates = Path {
    "aggregates"
  }

  public static let providers = Path {
    "providers"
  }

  public static let devices = Path {
    "devices"
  }

  public static let countries = Path {
    "countries"
  }
}
