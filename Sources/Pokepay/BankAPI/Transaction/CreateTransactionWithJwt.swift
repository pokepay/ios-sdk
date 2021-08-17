import APIKit

public extension BankAPI.Transaction {
    struct CreateWithJwt: BankRequest {
        public let data: String
        public let accountId: String?
        public let couponId:String?

        public typealias Response = JwtResult

        public init(data: String, accountId: String? = nil, couponId:String? = nil) {
            self.data = data
            self.accountId = accountId
            self.couponId = couponId
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
            return dict
        }
    }
}
