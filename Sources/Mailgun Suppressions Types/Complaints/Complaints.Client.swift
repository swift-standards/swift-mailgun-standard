// Complaints.Client.swift
import DependenciesMacros
import Mailgun_Types_Shared

extension Mailgun.Suppressions.Complaints {
    @DependencyClient
    public struct Client: Sendable {
        @DependencyEndpoint
        public var importList: @Sendable (_ request: Mailgun.Suppressions.Complaints.Import.Request) async throws -> Mailgun.Suppressions.Complaints.Import.Response

        @DependencyEndpoint
        public var get: @Sendable (_ address: EmailAddress) async throws -> Mailgun.Suppressions.Complaints.Get.Response

        @DependencyEndpoint
        public var delete: @Sendable (_ address: EmailAddress) async throws -> Mailgun.Suppressions.Complaints.Delete.Response

        @DependencyEndpoint
        public var list: @Sendable (_ request: Mailgun.Suppressions.Complaints.List.Request?) async throws -> Mailgun.Suppressions.Complaints.List.Response

        @DependencyEndpoint
        public var create: @Sendable (_ request: Mailgun.Suppressions.Complaints.Create.Request) async throws -> Mailgun.Suppressions.Complaints.Create.Response

        @DependencyEndpoint
        public var deleteAll: @Sendable () async throws -> Mailgun.Suppressions.Complaints.Delete.All.Response
    }
}
