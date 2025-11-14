//
//  File.swift
//  swift-mailgun
//
//  Created by Coen ten Thije Boonkkamp on 24/12/2024.
//

import Mailgun_Types_Shared

extension Mailgun.Domains.Domains {
    @CasePathable
    @dynamicMemberLookup
    public enum API: Equatable, Sendable {
        case list(request: Mailgun.Domains.Domains.List.Request?)
        case create(request: Mailgun.Domains.Domains.Create.Request)
        case get(domain: Domain)
        case update(domain: Domain, request: Mailgun.Domains.Domains.Update.Request)
        case delete(domain: Domain)
        case verify(domain: Domain)
    }
}

extension Mailgun.Domains.Domains.API {
    public struct Router: ParserPrinter, Sendable {
        public init() {}

        public var body: some URLRouting.Router<Mailgun.Domains.Domains.API> {
            OneOf {
                URLRouting.Route(.case(Mailgun.Domains.Domains.API.list)) {
                    Method.get
                    Path { "v4" }
                    Path { "domains" }
                    Optionally {
                        Parse(.memberwise(Mailgun.Domains.Domains.List.Request.init)) {
                            URLRouting.Query {
                                Optionally {
                                    Field("authority") { Parse(.string) }
                                }
                                Optionally {
                                    Field("state") {
                                        Parse(
                                            .string.representing(Mailgun.Domains.Domains.State.self)
                                        )
                                    }
                                }
                                Optionally {
                                    Field("limit") { Digits() }
                                }
                                Optionally {
                                    Field("skip") { Digits() }
                                }
                            }
                        }
                    }
                }

                URLRouting.Route(.case(Mailgun.Domains.Domains.API.create)) {
                    Method.post
                    Path { "v4" }
                    Path { "domains" }
                    Body(
                        .form(
                            Mailgun.Domains.Domains.Create.Request.self,
                            decoder: .mailgun,
                            encoder: .mailgun
                        )
                    )
                }

                URLRouting.Route(.case(Mailgun.Domains.Domains.API.get)) {
                    Method.get
                    Path { "v4" }
                    Path { "domains" }
                    Path { Parse(.string.representing(Domain.self)) }
                }

                URLRouting.Route(.case(Mailgun.Domains.Domains.API.update)) {
                    Method.put
                    Path { "v4" }
                    Path { "domains" }
                    Path { Parse(.string.representing(Domain.self)) }
                    Body(
                        .form(
                            Mailgun.Domains.Domains.Update.Request.self,
                            decoder: .mailgun,
                            encoder: .mailgun
                        )
                    )
                }

                URLRouting.Route(.case(Mailgun.Domains.Domains.API.delete)) {
                    Method.delete
                    Path { "v4" }
                    Path { "domains" }
                    Path { Parse(.string.representing(Domain.self)) }
                }

                URLRouting.Route(.case(Mailgun.Domains.Domains.API.verify)) {
                    Method.put
                    Path { "v4" }
                    Path { "domains" }
                    Path { Parse(.string.representing(Domain.self)) }
                    Path { "verify" }
                }
            }
        }
    }
}
