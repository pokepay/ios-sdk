import APIKit

public extension BankAPI.User {
    struct GetUserCards: BankRequest {
        public let id: String
        public let before: String?
        public let after: String?
        public let perPage: Int32?
        
        public typealias Response = PaginatedCards
        
        public init(id: String, before: String? = nil, after: String? = nil, perPage: Int32? = nil) {
            self.id = id
            self.before = before
            self.after = after
            self.perPage = perPage
        }
        
        public var method: HTTPMethod {
            return .get
        }
        
        public var path: String {
            return "/users/\(id)/cards"
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
