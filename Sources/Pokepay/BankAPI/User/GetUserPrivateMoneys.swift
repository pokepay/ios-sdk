import APIKit

public extension BankAPI.User {
    struct GetUserPrivateMoneys: BankRequest {
        public let userId: String

        public typealias Response = [PrivateMoney]

        public init(userId: String) {
            self.userId = userId
        }

        public var method: HTTPMethod {
            return .get
        }

        public var path: String {
            return "/users/\(userId)/private-moneys"
        }
    }
}
