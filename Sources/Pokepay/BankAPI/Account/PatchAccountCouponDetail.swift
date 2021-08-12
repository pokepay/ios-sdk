import APIKit

public extension BankAPI.Account {
    struct PatchCouponDetail:BankRequest {
        public let accountId: String
        public let couponId:String

        public typealias Response = CouponDetail

        public init(accountId: String, couponId:String) {
            self.accountId = accountId
            self.couponId = couponId
        }

        public var method: HTTPMethod {
            return .patch
        }

        public var path: String {
            return "/accounts/\(accountId)/coupons/\(couponId)"
        }
    }
}

