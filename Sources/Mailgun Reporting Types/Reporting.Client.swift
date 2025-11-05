//
//  File.swift
//  swift-mailgun
//
//  Created by Coen ten Thije Boonkkamp on 24/12/2024.
//

import Dependencies
import Mailgun_Types_Shared

extension Mailgun.Reporting {
    public struct Client: Sendable {
        public let metrics: Metrics.Client
        public let stats: Stats.Client
        public let events: Events.Client
        public let tags: Tags.Client
        public let logs: Logs.Client

        public init(
            metrics: Metrics.Client,
            stats: Stats.Client,
            events: Events.Client,
            tags: Tags.Client,
            logs: Logs.Client
        ) {
            self.metrics = metrics
            self.stats = stats
            self.events = events
            self.tags = tags
            self.logs = logs
        }
    }
}
