import APIKit

public extension BankAPI.Transaction {
    struct CreateWithJwt: BankRequest {
        
        public enum Strategy: String {
            case pointPreferred = "point-preferred"
            case moneyOnly = "money-only"
        }
        
        public let data: String
        public let accountId: String?
        public let couponId:String?
        public let strategy: Strategy?

        public typealias Response = JwtResult

        public init(data: String, accountId: String? = nil, couponId:String? = nil, strategy: Strategy? = .pointPreferred) {
            self.data = data
            self.accountId = accountId
            self.couponId = couponId
            self.strategy = strategy
        }

        public var method: HTTPMethod {
            return .post
        }

        public var path: String {
            return "/transactions"
        }

        public var parameters: Any? {
            var dict = ["data": data]
            if accountId != nil {
                dict["account_id"] = accountId
            }
            if couponId != nil {
                dict["coupon_id"] = couponId
            }
            if strategy != nil {
                dict["strategy"] = strategy?.rawValue
            }
            return dict
        }
    }
}
