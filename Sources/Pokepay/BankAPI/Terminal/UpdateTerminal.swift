import APIKit

public extension BankAPI.Terminal {
    struct Update: BankRequest {
        let accountId: String
        let name: String
        let pushToken: String?

        public typealias Response = Terminal

        public init(name: String, accountId: String, pushToken: String? = nil) {
            self.name = name
            self.accountId = accountId
            self.pushToken = pushToken
        }

        public var method: HTTPMethod {
            return .patch
        }

        public var path: String {
            return "/terminal"
        }

        public var parameters: Any? {
            return [
              "account_id": accountId,
              "name": name,
              "push_token": pushToken
            ]
        }
    }
}
