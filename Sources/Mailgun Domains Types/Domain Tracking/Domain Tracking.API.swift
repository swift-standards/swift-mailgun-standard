//
//  File.swift
//  swift-mailgun
//
//  Created by Coen ten Thije Boonkkamp on 24/12/2024.
//

import Mailgun_Types_Shared

extension Mailgun.Domains.Domains.Tracking {
    @CasePathable
    @dynamicMemberLookup
    public enum API: Equatable, Sendable {
        case get(domain: Domain)
        case updateClick(
            domain: Domain,
            request: Mailgun.Domains.Domains.Tracking.UpdateClick.Request
        )
        case updateOpen(
            domain: Domain,
            request: Mailgun.Domains.Domains.Tracking.UpdateOpen.Request
        )
        case updateUnsubscribe(
            domain: Domain,
            request: Mailgun.Domains.Domains.Tracking.UpdateUnsubscribe.Request
        )
    }
}

extension Mailgun.Domains.Domains.Tracking.API {
    public struct Router: ParserPrinter, Sendable {
        public init() {}

        public var body: some URLRouting.Router<Mailgun.Domains.Domains.Tracking.API> {
            OneOf {
                URLRouting.Route(.case(Mailgun.Domains.Domains.Tracking.API.get)) {
                    Method.get
                    Path { "v3" }
                    Path { "domains" }
                    Path { Parse(.string.representing(Domain.self)) }
                    Path { "tracking" }
                }

                URLRouting.Route(.case(Mailgun.Domains.Domains.Tracking.API.updateClick)) {
                    Method.put
                    Path { "v3" }
                    Path { "domains" }
                    Path { Parse(.string.representing(Domain.self)) }
                    Path { "tracking" }
                    Path { "click" }
                    Body(
                        .form(
                            Mailgun.Domains.Domains.Tracking.UpdateClick.Request.self,
                            decoder: .mailgun,
                            encoder: .mailgun
                        )
                    )
                }

                URLRouting.Route(.case(Mailgun.Domains.Domains.Tracking.API.updateOpen)) {
                    Method.put
                    Path { "v3" }
                    Path { "domains" }
                    Path { Parse(.string.representing(Domain.self)) }
                    Path { "tracking" }
                    Path { "open" }
                    Body(
                        .form(
                            Mailgun.Domains.Domains.Tracking.UpdateOpen.Request.self,
                            decoder: .mailgun,
                            encoder: .mailgun
                        )
                    )
                }

                URLRouting.Route(.case(Mailgun.Domains.Domains.Tracking.API.updateUnsubscribe)) {
                    Method.put
                    Path { "v3" }
                    Path { "domains" }
                    Path { Parse(.string.representing(Domain.self)) }
                    Path { "tracking" }
                    Path { "unsubscribe" }
                    Body(
                        .form(
                            Mailgun.Domains.Domains.Tracking.UpdateUnsubscribe.Request.self,
                            decoder: .mailgun,
                            encoder: .mailgun
                        )
                    )
                }
            }
        }
    }
}
