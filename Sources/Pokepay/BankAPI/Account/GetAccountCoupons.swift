import APIKit

public extension BankAPI.Account {
    struct GetAccountCoupons: BankRequest {
        public let accountId: String
        public let isAvailable:Bool?
        public let before: String?
        public let after: String?
        public let perPage: Int32?

        public typealias Response = PaginatedCoupons

        public init(accountId: String,isAvailable:Bool? = nil , before: String? = nil, after: String? = nil, perPage: Int32? = nil) {
            self.accountId = accountId
            self.isAvailable = isAvailable
            self.before = before
            self.after = after
            self.perPage = perPage
        }

        public var method: HTTPMethod {
            return .get
        }

        public var path: String {
            return "/accounts/\(accountId)/coupons"
        }

        public var parameters: Any? {
            var dict: [String: Any] = [:]
            if isAvailable != nil {
                dict["is_available"] = isAvailable
            }
            if before != nil {
                dict["before"] = before
            }
            if after != nil {
                dict["after"] = after
            }
            if perPage != nil {
                dict["per_page"] = perPage
            }
            return dict
        }
    }
}
