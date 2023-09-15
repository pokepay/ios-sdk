import APIKit

public extension BankAPI.User {
    struct CreateBankPay: BankRequest {
        public let id: String
        public let callbackUrl: String
        public let privateMoneyId: String
        public typealias Response = BankPayRedirectUrl
        
        public init(id: String, token: String) {
            self.id = id
            self.callbackUrl = callbackUrl
            self.privateMoneyId = privateMoneyId
        }
        
        public var method: HTTPMethod {
            return .post
        }
        
        public var path: String {
            return "/users/\(id)/banks"
        }

        public var parameters: Any? {
            var dict: [String: Any] = [:]

            dict["callbackUrl"] = callbackUrl
            dict["privateMoneyId"] = privateMoneyId
            
            return dict
        }
    }
}
