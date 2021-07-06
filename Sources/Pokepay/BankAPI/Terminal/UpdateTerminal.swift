import APIKit

public extension BankAPI.Terminal {
    struct Update: BankRequest {
        let accountId: String
        let name: String
        let pushToken: String?

        typealias Response = Terminal

        public init(name: String, accountId: String, pushToken: String? = nil) {
            self.name = name
            self.accountId = accountId
            self.pushToken = pushToken
        }

        var method: HTTPMethod {
            return .patch
        }

        var path: String {
            return "/terminal"
        }

        var parameters: Any? {
            return [
              "account_id": accountId,
              "name": name,
              "push_token": pushToken
            ]
        }
    }
}
