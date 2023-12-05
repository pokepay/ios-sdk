import APIKit

public extension BankAPI.User {
    struct DeleteBankPay: BankRequest {
        public let id: String
        public let bankId: String

        public typealias Response = NoContent
        
        public init(id: String, bankId: String) {
            self.id = id
            self.bankId = bankId
        }
        
        public var method: HTTPMethod {
            return .delete
        }
        
        public var path: String {
            return "/users/\(id)/banks"
        }

        public var parameters: Any? {
            var dict: [String: Any] = [:]

            dict["bank_id"] = bankId
            
            return dict
        }
    }
}
