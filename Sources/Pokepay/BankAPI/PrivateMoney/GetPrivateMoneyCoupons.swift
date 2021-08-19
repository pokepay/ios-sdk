import APIKit

public extension BankAPI.PrivateMoney {
    struct GetPrivateMoneyCoupons: BankRequest {
        public let privateMoneyId:String
        public let before:String?
        public let after:String?
        public let perPage:Int32?
        
        public typealias Response = PaginatedCoupons
        
        public init(privateMoneyId: String, before: String? = nil, after: String? = nil, perPage: Int32? = nil){
            self.privateMoneyId = privateMoneyId
            self.before = before
            self.after = after
            self.perPage = perPage
        }
        
        public var method: HTTPMethod {
            return .get
        }
        
        public var path: String {
            return "/private-moneys/\(privateMoneyId)/coupons"
        }
        
        public var parameters: Any? {
            var dict: [String: Any] = [:]
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
