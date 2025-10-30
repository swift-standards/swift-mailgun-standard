//
//  File.swift
//  swift-mailgun
//
//  Created by Coen ten Thije Boonkkamp on 24/12/2024.
//

import Mailgun_Types_Shared

extension Mailgun.Domains.DKIM_Security {
  @CasePathable
  @dynamicMemberLookup
  public enum API: Equatable, Sendable {
    case updateRotation(
      domain: TypesFoundation.Domain,
      request: Mailgun.Domains.DKIM_Security.Rotation.Update.Request
    )
    case rotateManually(domain: TypesFoundation.Domain)
  }
}

extension Mailgun.Domains.DKIM_Security.API {
  public struct Router: ParserPrinter, Sendable {
    public init() {}

    public var body: some URLRouting.Router<Mailgun.Domains.DKIM_Security.API> {
      OneOf {
        URLRouting.Route(.case(Mailgun.Domains.DKIM_Security.API.updateRotation)) {
          Method.put
          Path { "v1" }
          Path { "dkim_management" }
          Path { "domains" }
          Path { Parse(.string.representing(TypesFoundation.Domain.self)) }
          Path { "rotation" }
          Body(
            .form(
              Mailgun.Domains.DKIM_Security.Rotation.Update.Request.self,
              decoder: .mailgun,
              encoder: .mailgun
            )
          )
        }

        URLRouting.Route(.case(Mailgun.Domains.DKIM_Security.API.rotateManually)) {
          Method.post
          Path { "v1" }
          Path { "dkim_management" }
          Path { "domains" }
          Path { Parse(.string.representing(TypesFoundation.Domain.self)) }
          Path { "rotate" }
        }
      }
    }
  }
}
