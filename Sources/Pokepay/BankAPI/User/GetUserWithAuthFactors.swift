import APIKit

public extension BankAPI.User {
    @available(*, deprecated, message: "Use Autogen.BankAPI.User.GetUserWithAuthFactors instead. This hand-written request is being replaced by the auto-generated Autogen API.")
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
