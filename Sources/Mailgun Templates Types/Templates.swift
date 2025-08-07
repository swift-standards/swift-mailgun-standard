//
//  Template.swift
//  coenttb-mailgun
//
//  Created by Coen ten Thije Boonkkamp on 30/12/2024.
//

@_exported import Mailgun_Types_Shared

extension Mailgun {
    public enum Templates {}
}

extension Mailgun.Templates {
    public struct Template: Sendable, Codable, Equatable {
        public let name: String
        public let description: String?
        public let createdAt: String?
        public let createdBy: String?
        public let id: String?
        public let version: Version?
        public let versions: [Version]?

        public init(
            name: String,
            description: String? = nil,
            createdAt: String? = nil,
            createdBy: String? = nil,
            id: String? = nil,
            version: Version? = nil,
            versions: [Version]? = nil
        ) {
            self.name = name
            self.description = description
            self.createdAt = createdAt
            self.createdBy = createdBy
            self.id = id
            self.version = version
            self.versions = versions
        }
    }
}

extension Mailgun.Templates {
    public struct Version: Sendable, Codable, Equatable {
        public let tag: String
        public let template: String?
        public let engine: String?
        public let mjml: String?
        public let createdAt: String?
        public let comment: String?
        public let active: Bool?
        public let id: String?
        public let headers: [String: String]?

        public init(
            tag: String,
            template: String? = nil,
            engine: String? = nil,
            mjml: String? = nil,
            createdAt: String? = nil,
            comment: String? = nil,
            active: Bool? = nil,
            id: String? = nil,
            headers: [String: String]? = nil
        ) {
            self.tag = tag
            self.template = template
            self.engine = engine
            self.mjml = mjml
            self.createdAt = createdAt
            self.comment = comment
            self.active = active
            self.id = id
            self.headers = headers
        }
    }
}

extension Mailgun.Templates {
    public struct Paging: Sendable, Codable, Equatable {
        public let first: String
        public let last: String
        public let next: String?
        public let previous: String?

        public init(
            first: String,
            last: String,
            next: String? = nil,
            previous: String? = nil
        ) {
            self.first = first
            self.last = last
            self.next = next
            self.previous = previous
        }
    }
}

extension Mailgun.Templates {
    public enum Page: String, Codable, Hashable, Sendable {
        case first
        case last
        case next
        case previous
    }
}

// MARK: - List
extension Mailgun.Templates {
    public enum List {}
}

extension Mailgun.Templates.List {
    public struct Request: Sendable, Codable, Equatable {
        public let page: Mailgun.Templates.Page?
        public let limit: Int?
        public let p: String?

        public init(
            page: Mailgun.Templates.Page? = nil,
            limit: Int? = nil,
            p: String? = nil
        ) {
            self.page = page
            self.limit = limit
            self.p = p
        }
    }

    public struct Response: Sendable, Decodable, Equatable {
        public let items: [Mailgun.Templates.Template]?
        public let paging: Mailgun.Templates.Paging

        public init(items: [Mailgun.Templates.Template]?, paging: Mailgun.Templates.Paging) {
            self.items = items
            self.paging = paging
        }
    }
}

// MARK: - Create
extension Mailgun.Templates {
    public enum Create {}
}

extension Mailgun.Templates.Create {
    public struct Request: Sendable, Codable, Equatable {
        public let name: String
        public let description: String?
        public let createdBy: String?
        public let template: String?
        public let tag: String?
        public let comment: String?
        public let headers: String?

        public init(
            name: String,
            description: String? = nil,
            createdBy: String? = nil,
            template: String? = nil,
            tag: String? = nil,
            comment: String? = nil,
            headers: String? = nil
        ) {
            self.name = name
            self.description = description
            self.createdBy = createdBy
            self.template = template
            self.tag = tag
            self.comment = comment
            self.headers = headers
        }
    }

    public struct Response: Sendable, Decodable, Equatable {
        public let message: String
        public let template: Mailgun.Templates.Template?

        public init(message: String, template: Mailgun.Templates.Template?) {
            self.message = message
            self.template = template
        }
    }
}

// MARK: - Delete All
extension Mailgun.Templates {
    public enum DeleteAll {}
}

extension Mailgun.Templates.DeleteAll {
    public struct Response: Sendable, Decodable, Equatable {
        public let message: String

        public init(message: String) {
            self.message = message
        }
    }
}

// MARK: - Get
extension Mailgun.Templates {
    public enum Get {}
}

extension Mailgun.Templates.Get {
    public struct Request: Sendable, Codable, Equatable {
        public let active: String?

        public init(active: String? = nil) {
            self.active = active
        }
    }

    public struct Response: Sendable, Decodable, Equatable {
        public let template: Mailgun.Templates.Template?

        public init(template: Mailgun.Templates.Template?) {
            self.template = template
        }
    }
}

// MARK: - Update
extension Mailgun.Templates {
    public enum Update {}
}

extension Mailgun.Templates.Update {
    public struct Request: Sendable, Codable, Equatable {
        public let description: String?

        public init(description: String?) {
            self.description = description
        }
    }

    public struct Response: Sendable, Decodable, Equatable {
        public let message: String
        public let template: TemplateUpdate

        public init(message: String, template: TemplateUpdate) {
            self.message = message
            self.template = template
        }

        public struct TemplateUpdate: Sendable, Decodable, Equatable {
            public let name: String
            public let version: VersionUpdate?

            public init(name: String, version: VersionUpdate? = nil) {
                self.name = name
                self.version = version
            }
        }

        public struct VersionUpdate: Sendable, Decodable, Equatable {
            // Version update details if needed
        }
    }
}

// MARK: - Delete
extension Mailgun.Templates {
    public enum Delete {}
}

extension Mailgun.Templates.Delete {
    public struct Response: Sendable, Decodable, Equatable {
        public let message: String
        public let template: TemplateDelete

        public init(message: String, template: TemplateDelete) {
            self.message = message
            self.template = template
        }

        public struct TemplateDelete: Sendable, Decodable, Equatable {
            public let name: String
            public let version: VersionDelete?

            public init(name: String, version: VersionDelete? = nil) {
                self.name = name
                self.version = version
            }
        }

        public struct VersionDelete: Sendable, Decodable, Equatable {
            // Version delete details if needed
        }
    }
}

// MARK: - Versions
extension Mailgun.Templates {
    public enum Versions {}
}

extension Mailgun.Templates.Versions {
    public struct Request: Sendable, Codable, Equatable {
        public let page: Mailgun.Templates.Page?
        public let limit: Int?
        public let p: String?

        public init(
            page: Mailgun.Templates.Page? = nil,
            limit: Int? = nil,
            p: String? = nil
        ) {
            self.page = page
            self.limit = limit
            self.p = p
        }
    }

    public struct Response: Sendable, Decodable, Equatable {
        public let template: Mailgun.Templates.Template?
        public let paging: Mailgun.Templates.Paging

        public init(template: Mailgun.Templates.Template?, paging: Mailgun.Templates.Paging) {
            self.template = template
            self.paging = paging
        }
    }
}

// MARK: - Version Operations
extension Mailgun.Templates.Version {
    // MARK: - Create Version
    public enum Create {}
}

extension Mailgun.Templates.Version.Create {
    public struct Request: Sendable, Codable, Equatable {
        public let template: String
        public let tag: String
        public let comment: String?
        public let active: String?
        public let headers: String?

        public init(
            template: String,
            tag: String,
            comment: String? = nil,
            active: String? = nil,
            headers: String? = nil
        ) {
            self.template = template
            self.tag = tag
            self.comment = comment
            self.active = active
            self.headers = headers
        }
    }

    public struct Response: Sendable, Decodable, Equatable {
        public let message: String
        public let template: Mailgun.Templates.Template?

        public init(message: String, template: Mailgun.Templates.Template?) {
            self.message = message
            self.template = template
        }
    }
}

// MARK: - Get Version
extension Mailgun.Templates.Version {
    public enum Get {}
}

extension Mailgun.Templates.Version.Get {
    public struct Response: Sendable, Decodable, Equatable {
        public let template: Mailgun.Templates.Template?

        public init(template: Mailgun.Templates.Template?) {
            self.template = template
        }
    }
}

// MARK: - Update Version
extension Mailgun.Templates.Version {
    public enum Update {}
}

extension Mailgun.Templates.Version.Update {
    public struct Request: Sendable, Codable, Equatable {
        public let template: String?
        public let comment: String?
        public let active: String?
        public let headers: String?

        public init(
            template: String? = nil,
            comment: String? = nil,
            active: String? = nil,
            headers: String? = nil
        ) {
            self.template = template
            self.comment = comment
            self.active = active
            self.headers = headers
        }
    }

    public struct Response: Sendable, Decodable, Equatable {
        public let message: String
        public let template: TemplateUpdate

        public init(message: String, template: TemplateUpdate) {
            self.message = message
            self.template = template
        }

        public struct TemplateUpdate: Sendable, Decodable, Equatable {
            public let name: String
            public let version: VersionUpdate?

            public init(name: String, version: VersionUpdate? = nil) {
                self.name = name
                self.version = version
            }
        }

        public struct VersionUpdate: Sendable, Decodable, Equatable {
            // Version update details if needed
        }
    }
}

// MARK: - Delete Version
extension Mailgun.Templates.Version {
    public enum Delete {}
}

extension Mailgun.Templates.Version.Delete {
    public struct Response: Sendable, Decodable, Equatable {
        public let message: String
        public let template: TemplateDelete

        public init(message: String, template: TemplateDelete) {
            self.message = message
            self.template = template
        }

        public struct TemplateDelete: Sendable, Decodable, Equatable {
            public let name: String
            public let version: VersionDelete?

            public init(name: String, version: VersionDelete? = nil) {
                self.name = name
                self.version = version
            }
        }

        public struct VersionDelete: Sendable, Decodable, Equatable {
            // Version delete details if needed
        }
    }
}

// MARK: - Copy Version
extension Mailgun.Templates.Version {
    public enum Copy {}
}

extension Mailgun.Templates.Version.Copy {
    public struct Request: Sendable, Codable, Equatable {
        public let comment: String?

        public init(comment: String? = nil) {
            self.comment = comment
        }
    }

    public struct Response: Sendable, Decodable, Equatable {
        public let message: String
        public let version: Mailgun.Templates.Version?
        public let template: Mailgun.Templates.Version? // Deprecated field

        public init(message: String, version: Mailgun.Templates.Version?, template: Mailgun.Templates.Version? = nil) {
            self.message = message
            self.version = version
            self.template = template
        }
    }
}
