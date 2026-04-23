import APIKit

public extension BankAPI.User {
    struct BankPayTopUp: BankRequest {
        public let id: String
        public let accountId: String
        public let bankId: String
        public let amount: String
        public typealias Response = UserTransaction
        public let requestId: String?
        public let topupQuotaId: Int?
        
        public init(id: String, accountId: String , bankId: String, amount: String, requestId: String? = nil, topupQuotaId: Int? = nil) {
            self.id = id
            self.accountId = accountId
            self.bankId = bankId
            self.amount = amount
            self.requestId = requestId
            self.topupQuotaId = topupQuotaId
        }
        
        public var method: HTTPMethod {
            return .post
        }
        
        public var path: String {
            return "/users/\(id)/banks/topup"
        }
        
        public var parameters: Any? {
            var dict: [String: Any] = [
                "account_id": accountId,
                "bank_id": bankId,
                "amount": amount
            ]
            if requestId != nil {
                dict["request_id"] = requestId
            }
            if topupQuotaId != nil {
                dict["topup_quota_id"] = topupQuotaId
            }

            return dict
        }
        
    }
}
