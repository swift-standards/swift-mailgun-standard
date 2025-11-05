//
//  Logs.swift
//  swift-mailgun-types
//
//  Created by Coen ten Thije Boonkkamp on 31/12/2024.
//

import Foundation
@_exported import Mailgun_Types_Shared

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
        public let startDate: Date?
        public let endDate: Date?
        public let filter: Filter?
        public let include: [Include]?
        public let page: Page?

        public init(
            action: String? = nil,
            groupBy: String? = nil,
            startDate: Date? = nil,
            endDate: Date? = nil,
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

        public init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()

            if let stringValue = try? container.decode(String.self) {
                self = .string(stringValue)
            } else if let intValue = try? container.decode(Int.self) {
                self = .int(intValue)
            } else if let doubleValue = try? container.decode(Double.self) {
                self = .double(doubleValue)
            } else if let boolValue = try? container.decode(Bool.self) {
                self = .bool(boolValue)
            } else if let arrayValue = try? container.decode([String].self) {
                self = .array(arrayValue)
            } else {
                throw DecodingError.dataCorruptedError(
                    in: container,
                    debugDescription: "Value must be String, Int, Double, Bool, or [String]"
                )
            }
        }

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
            public let timestamp: Date?
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
