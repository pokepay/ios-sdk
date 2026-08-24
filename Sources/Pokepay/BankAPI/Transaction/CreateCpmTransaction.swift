import APIKit

public extension BankAPI.Transaction {
    struct CreateCpmTransaction: BankRequest {
        public let requestId: String
        public let cpmToken: String
        public let accountId: String?
        public let amount: Double
        public let products: [Product]?
        public let topupQuotaId: Int?

        public typealias Response = UserTransactionWithFallback

        public init(requestId: String, cpmToken: String, accountId: String? = nil, amount: Double, products: [Product]? = nil, topupQuotaId: Int? = nil) {
            self.requestId = requestId
            self.cpmToken = cpmToken
            self.accountId = accountId
            self.amount = amount
            self.products = products
            self.topupQuotaId = topupQuotaId
        }

        public var method: HTTPMethod {
            return .post
        }

        public var path: String {
            return "/transactions/cpm"
        }

        public var parameters: Any? {
            var dict: [String: Any] = [:]

            dict["request_id"] = requestId

            dict["cpm_token"] = cpmToken

            if accountId != nil {
                dict["account_id"] = accountId
            }

            dict["amount"] = amount

            if products != nil {
                dict["products"] = products
            }

            if topupQuotaId != nil {
                dict["topup_quota_id"] = topupQuotaId
            }

            return dict
        }
    }
}
