import APIKit

public extension BankAPI.User {
    public struct DeleteEmail: BankRequest {
        public let id: String
        public let email: String

        public typealias Response = NoContent

        public init(id: String, email: String) {
            self.id = id
            self.email = email
        }

        public var method: HTTPMethod {
            return .delete
        }

        public var path: String {
            return "/users/\(id)/emails/\(email)"
        }
    }
}
