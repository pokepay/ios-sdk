import APIKit

public extension BankAPI.Account {
    struct PatchCouponDetail:BankRequest {
        public let accountId: String
        public let couponId:String
        public let isReceived: Bool

        public typealias Response = CouponDetail

        public init(accountId: String, couponId:String, isReceived: Bool) {
            self.accountId = accountId
            self.couponId = couponId
            self.isReceived = isReceived
        }

        public var method: HTTPMethod {
            return .patch
        }

        public var path: String {
            return "/accounts/\(accountId)/coupons/\(couponId)"
        }
        
        public var parameters: Any? {
            return [
              "is_received": isReceived
            ]
        }
    }
}

