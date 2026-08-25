import APIKit

public extension BankAPI.User {
    @available(*, deprecated, message: "Use Autogen.BankAPI.Bank.DeleteBankPay instead. This hand-written request is being replaced by the auto-generated Autogen API.")
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

        public var bodyParameters: BodyParameters? {
            var dict: [String: Any] = [:]

            dict["bank_id"] = bankId
            
            return JSONBodyParameters(JSONObject: dict)
        }
    }
}
