import APIKit

public extension BankAPI.User {
    struct CreateBankPay: BankRequest {
        public let id: String
        public let callbackUrl: String
        public let privateMoneyId: String
        public let kana: String?
        public typealias Response = BankPayRedirectUrl
        
        public init(id: String, callbackUrl: String, privateMoneyId: String, kana: String? = nil) {
            self.id = id
            self.callbackUrl = callbackUrl
            self.privateMoneyId = privateMoneyId
            self.kana = kana
        }
        
        public var method: HTTPMethod {
            return .post
        }
        
        public var path: String {
            return "/users/\(id)/banks"
        }

        public var parameters: Any? {
            var dict: [String: Any] = [:]

            dict["callback_url"] = callbackUrl
            dict["private_money_id"] = privateMoneyId

            if kana != nil {
                dict["kana"] = kana
            }
            
            return dict
        }
    }
}
