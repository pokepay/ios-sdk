import APIKit

public extension BankAPI.User {
    struct SendConfirmationEmail: BankRequest {
        public let id: String
        public let email: String

        public typealias Response = NoContent

        public init(id: String, email: String) {
            self.id = id
            self.email = email
        }

        public var method: HTTPMethod {
            return .put
        }

        public var path: String {
            return "/users/\(id)/emails/\(email)"
        }
    }
}
