import APIKit

public extension BankAPI.Account {
    public struct GetTransactions: BankRequest {
        public let id: String
        public let before: String?
        public let after: String?
        public let perPage: Int32?

        public typealias Response = PaginatedTransactions

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
            return "/accounts/\(id)/transactions"
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
