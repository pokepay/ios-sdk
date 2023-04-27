import APIKit

public extension BankAPI.User {
    struct GetUserWithAuthFactors: BankRequest {
        public let userId: String
        
        public typealias Response = UserWithAuthFactors
        
        public init(userId: String) {
            self.userId = userId
        }
        
        public var method: HTTPMethod {
            return .get
        }
        
        public var path: String {
            return "/users/\(userId)/auth-factors"
        }
        
    }
}
