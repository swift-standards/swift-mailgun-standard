public import Time

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
        public let startDate: Time.Instant?
        public let endDate: Time.Instant?
        public let filter: Filter?
        public let include: [Include]?
        public let page: Page?

        public init(
            action: String? = nil,
            groupBy: String? = nil,
            startDate: Time.Instant? = nil,
            endDate: Time.Instant? = nil,
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

        public init(from decoder: any Decoder) throws {
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

        private static func decoded<T: Decodable, Container: SingleValueDecodingContainer>(
            _ type: T.Type,
            from container: Container
        ) -> T? {

            try? container.decode(T.self)
        }

        public func encode(to encoder: any Encoder) throws {
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
            public let timestamp: Time.Instant?
            public let action: String?
            public let count: Int?

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
