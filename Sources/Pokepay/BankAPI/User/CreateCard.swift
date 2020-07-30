import APIKit

public extension BankAPI.User {
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
