import APIKit

public extension BankAPI.Account {
    @available(*, deprecated, message: "Use Autogen.BankAPI.Account.GetAccountCouponDetail instead. This hand-written request is being replaced by the auto-generated Autogen API.")
    struct GetCouponDetail:BankRequest {
        public let accountId: String
        public let couponId:String

        public typealias Response = CouponDetail

        public init(accountId: String, couponId:String) {
            self.accountId = accountId
            self.couponId = couponId
        }

        public var method: HTTPMethod {
            return .get
        }

        public var path: String {
            return "/accounts/\(accountId)/coupons/\(couponId)"
        }
    }
}
