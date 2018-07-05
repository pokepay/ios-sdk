import APIKit

public extension BankAPI.User {
    public struct RegisterEmail: BankRequest {
        public let token: String

        public typealias Response = NoContent

        public init(token: String) {
            self.token = token
        }

        public var method: HTTPMethod {
            return .post
        }

        public var path: String {
            return "/emails"
        }
    }
}
