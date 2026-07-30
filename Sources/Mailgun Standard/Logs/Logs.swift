//
//  Logs.swift
//  swift-mailgun-types
//
//  Created by Coen ten Thije Boonkkamp on 31/12/2024.
//

import Time_Primitive

extension Mailgun.Reporting {
    public enum Logs {}
}

extension Mailgun.Reporting.Logs {
    public enum Analytics {}
}

extension Mailgun.Reporting.Logs.Analytics {
    public struct Request: Sendable, Codable, Equatable {
        public let action: String?
        public let groupBy: String?
        public let startDate: Time.Epoch?
        public let endDate: Time.Epoch?
        public let filter: Filter?
        public let include: [Include]?
        public let page: Page?

        public init(
            action: String? = nil,
            groupBy: String? = nil,
            startDate: Time.Epoch? = nil,
            endDate: Time.Epoch? = nil,
            filter: Filter? = nil,
            include: [Include]? = nil,
            page: Page? = nil
        ) {
            self.action = action
            self.groupBy = groupBy
            self.startDate = startDate
            self.endDate = endDate
            self.filter = filter
            self.include = include
            self.page = page
        }

        private enum CodingKeys: String, CodingKey {
            case action
            case groupBy = "group_by"
            case startDate = "start_date"
            case endDate = "end_date"
            case filter
            case include
            case page
        }
    }

    public struct Filter: Sendable, Codable, Equatable {
        public let and: [Condition]?
        public let or: [Condition]?

        public init(
            and: [Condition]? = nil,
            or: [Condition]? = nil
        ) {
            self.and = and
            self.or = or
        }
    }

    public struct Condition: Sendable, Codable, Equatable {
        public let field: String
        public let `operator`: Operator
        public let value: Value

        public init(
            field: String,
            operator: Operator,
            value: Value
        ) {
            self.field = field
            self.operator = `operator`
            self.value = value
        }
    }

    public enum Operator: String, Sendable, Codable, Equatable {
        case equals = "="
        case notEquals = "!="
        case greaterThan = ">"
        case lessThan = "<"
        case greaterThanOrEqual = ">="
        case lessThanOrEqual = "<="
        case contains = "contains"
        case notContains = "!contains"
        case startsWith = "starts_with"
        case endsWith = "ends_with"
    }

    public enum Value: Sendable, Codable, Equatable {
        case string(String)
        case int(Int)
        case double(Double)
        case bool(Bool)
        case array([String])

        // REASON: `Swift.Decodable.init(from:)` is declared with untyped `throws`
        // upstream; a conforming implementation is signature-forced and cannot
        // express `throws(E)`.
        // swiftlint:disable:next typed_throws_required
        public init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()

            if let stringValue = Self.decoded(String.self, from: container) {
                self = .string(stringValue)
            } else if let intValue = Self.decoded(Int.self, from: container) {
                self = .int(intValue)
            } else if let doubleValue = Self.decoded(Double.self, from: container) {
                self = .double(doubleValue)
            } else if let boolValue = Self.decoded(Bool.self, from: container) {
                self = .bool(boolValue)
            } else if let arrayValue = Self.decoded([String].self, from: container) {
                self = .array(arrayValue)
            } else {
                throw DecodingError.dataCorruptedError(
                    in: container,
                    debugDescription: "Value must be String, Int, Double, Bool, or [String]"
                )
            }
        }

        /// Reads the container as `T`, or `nil` when the wire value is not that shape.
        ///
        /// `Value` is a five-shape union whose Mailgun wire form carries no discriminator, so
        /// the only way to identify the shape is to attempt each decode in turn. An
        /// unsuccessful attempt is the *discrimination signal*, not a failure; the exhausted
        /// case is reported by the `DecodingError.dataCorrupted` in ``init(from:)``.
        private static func decoded<T: Decodable, Container: SingleValueDecodingContainer>(
            _ type: T.Type,
            from container: Container
        ) -> T? {
            // REASON: `SingleValueDecodingContainer.decode(_:)` is declared untyped `throws`,
            // so `do throws(E)` does not compile; and an unsuccessful probe here means "the
            // wire value is not this shape", which is the discrimination signal this
            // discriminator-less union has no other way to obtain.
            // swiftlint:disable:next no_try_optional
            try? container.decode(T.self)
        }

        // REASON: `Swift.Encodable.encode(to:)` is declared with untyped `throws`
        // upstream; a conforming implementation is signature-forced and cannot
        // express `throws(E)`.
        // swiftlint:disable:next typed_throws_required
        public func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            switch self {
            case .string(let value):
                try container.encode(value)

            case .int(let value):
                try container.encode(value)

            case .double(let value):
                try container.encode(value)

            case .bool(let value):
                try container.encode(value)

            case .array(let value):
                try container.encode(value)
            }
        }
    }

    public enum Include: String, Sendable, Codable, Equatable {
        case actions
        case total
        case resolution
    }

    public struct Page: Sendable, Codable, Equatable {
        public let size: Int?
        public let number: Int?
        public let sort: String?

        public init(
            size: Int? = nil,
            number: Int? = nil,
            sort: String? = nil
        ) {
            self.size = size
            self.number = number
            self.sort = sort
        }
    }

    public struct Response: Sendable, Decodable, Equatable {
        public let data: [LogEntry]?
        public let meta: Meta?

        public struct LogEntry: Sendable, Decodable, Equatable {
            public let timestamp: Time.Epoch?
            public let action: String?
            public let count: Int?
            // Attributes would contain arbitrary JSON, simplified for now
            // public let attributes: [String: AnyCodable]?
        }

        public struct Meta: Sendable, Decodable, Equatable {
            public let total: Int?
            public let page: PageInfo?

            public struct PageInfo: Sendable, Decodable, Equatable {
                public let size: Int?
                public let number: Int?
                public let totalPages: Int?

                private enum CodingKeys: String, CodingKey {
                    case size
                    case number
                    case totalPages = "total_pages"
                }
            }
        }
    }
}
