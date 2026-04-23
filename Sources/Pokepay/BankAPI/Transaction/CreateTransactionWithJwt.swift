import APIKit

public extension BankAPI.Transaction {
    struct CreateWithJwt: BankRequest {
        
        public let data: String
        public let accountId: String?
        public let couponId:String?
        public let strategy: TransactionStrategy?
        public let topupQuotaId: Int?

        public typealias Response = JwtResult

        public init(data: String, accountId: String? = nil, couponId:String? = nil, strategy: TransactionStrategy? = .pointPreferred, topupQuotaId: Int? = nil) {
            self.data = data
            self.accountId = accountId
            self.couponId = couponId
            self.strategy = strategy
            self.topupQuotaId = topupQuotaId
        }

        public var method: HTTPMethod {
            return .post
        }

        public var path: String {
            return "/transactions"
        }

        public var parameters: Any? {
            var dict: [String: Any] = [:]
            dict["data"] = data
            if accountId != nil {
                dict["account_id"] = accountId
            }
            if couponId != nil {
                dict["coupon_id"] = couponId
            }
            if strategy != nil {
                dict["strategy"] = strategy?.rawValue
            }
            if topupQuotaId != nil {
                dict["topup_quota_id"] = topupQuotaId
            }
            return dict
        }
    }
}
