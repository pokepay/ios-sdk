import APIKit

public extension BankAPI.Transaction {
    struct CreateWithCpm: BankRequest {
        public let cpmToken: String
        public let accountId: String?
        public let amount: Double?

        public typealias Response = UserTransaction

        public init(cpmToken: String, accountId: String? = nil, amount: Double? = nil) {
            self.cpmToken = cpmToken
            self.accountId = accountId
            self.amount = amount
        }

        public var method: HTTPMethod {
            return .post
        }

        public var path: String {
            return "/transactions"
        }

        public var parameters: Any? {
            var dict: [String: Any] = ["cpm_token": cpmToken]
            if accountId != nil {
                dict["account_id"] = accountId
            }
            if amount != nil {
                dict["amount"] = amount
            }
            return dict
        }
    }
}
