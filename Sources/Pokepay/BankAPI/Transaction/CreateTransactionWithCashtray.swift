import APIKit

public extension BankAPI.Transaction {
    struct CreateWithCashtray: BankRequest {
        
        public let cashtrayId: String
        public let accountId: String?
        public let couponId:String?
        public let strategy:TransactionStrategy?

        public typealias Response = UserTransaction

        public init(cashtrayId: String, accountId: String? = nil, couponId:String? = nil, strategy:TransactionStrategy? = .pointPreferred) {
            self.cashtrayId = cashtrayId
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
            var dict = ["cashtray_id": cashtrayId]
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
