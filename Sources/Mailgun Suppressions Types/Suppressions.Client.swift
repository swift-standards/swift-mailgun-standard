//
//  File.swift
//  swift-mailgun
//
//  Created by Coen ten Thije Boonkkamp on 24/12/2024.
//

import Dependencies
import Mailgun_Types_Shared
extension Mailgun.Suppressions {
    public struct Client: Sendable {
        public let bounces: Bounces.Client
        public let complaints: Complaints.Client
        public let unsubscribe: Unsubscribe.Client
        public let Allowlist: Allowlist.Client

        public init(
            bounces: Mailgun.Suppressions.Bounces.Client,
            complaints: Complaints.Client,
            unsubscribe: Unsubscribe.Client,
            Allowlist: Allowlist.Client
        ) {
            self.bounces = bounces
            self.complaints = complaints
            self.unsubscribe = unsubscribe
            self.Allowlist = Allowlist
        }
    }
}
