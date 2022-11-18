import APIKit

public extension BankAPI.Account {
    struct PatchCouponDetail:BankRequest {
        public let accountId: String
        public let couponId:String
        public let isReceived: Bool
        public let code: String?

        public typealias Response = CouponDetail

        public init(accountId: String, couponId:String, isReceived: Bool = true, code: String? = nil) {
            self.accountId = accountId
            self.couponId = couponId
            self.isReceived = isReceived
            self.code = code
        }

        public var method: HTTPMethod {
            return .patch
        }

        public var path: String {
            return "/accounts/\(accountId)/coupons/\(couponId)"
        }
        
        public var parameters: Any? {
            var dict: [String: Any] = [:]
            dict["is_received"] = isReceived
            if code != nil {
                dict["code"] = code
            }
            return dict
        }
    }
}

