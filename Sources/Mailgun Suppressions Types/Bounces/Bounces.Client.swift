import DependenciesMacros
import Mailgun_Types_Shared

extension Mailgun.Suppressions.Bounces {
    @DependencyClient
    public struct Client: Sendable {
        @DependencyEndpoint
        public var importList: @Sendable (_ request: Foundation.Data) async throws -> Mailgun.Suppressions.Bounces.Import.Response

        @DependencyEndpoint
        public var get: @Sendable (_ address: EmailAddress) async throws -> Mailgun.Suppressions.Bounces.Record

        @DependencyEndpoint
        public var delete: @Sendable (_ address: EmailAddress) async throws -> Mailgun.Suppressions.Bounces.Delete.Response

        @DependencyEndpoint
        public var list: @Sendable (_ request: Mailgun.Suppressions.Bounces.List.Request?) async throws -> Mailgun.Suppressions.Bounces.List.Response

        @DependencyEndpoint
        public var create: @Sendable (_ request: Mailgun.Suppressions.Bounces.Create.Request) async throws -> Mailgun.Suppressions.Bounces.Create.Response

        @DependencyEndpoint
        public var deleteAll: @Sendable () async throws -> Mailgun.Suppressions.Bounces.Delete.All.Response
    }
}
