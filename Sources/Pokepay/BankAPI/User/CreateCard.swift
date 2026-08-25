import APIKit

public extension BankAPI.User {
    @available(*, deprecated, message: "Use Autogen.BankAPI.CreditCard.CreateCreditCard instead. This hand-written request is being replaced by the auto-generated Autogen API.")
    struct CreateCard: BankRequest {
        public let id: String
        public let token: String
        public typealias Response = Card
        
        public init(id: String, token: String) {
            self.id = id
            self.token = token
        }
        
        public var method: HTTPMethod {
            return .post
        }
        
        public var path: String {
            return "/users/\(id)/cards"
        }

        public var parameters: Any? {
            let dict = ["token": token]
            return dict
        }
    }
}
