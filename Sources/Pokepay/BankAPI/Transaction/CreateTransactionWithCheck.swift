import APIKit

public extension BankAPI.Transaction {
    struct CreateWithCheck: BankRequest {
        public let checkId: String
        public let accountId: String?

        public typealias Response = UserTransaction

        public init(checkId: String, accountId: String? = nil) {
            self.checkId = checkId
            self.accountId = accountId
        }

        public var method: HTTPMethod {
            return .post
        }

        public var path: String {
            return "/transactions"
        }

        public var parameters: Any? {
            var dict = ["check_id": checkId]
            if accountId != nil {
                dict["account_id"] = accountId
            }
            return dict
        }
    }
}
