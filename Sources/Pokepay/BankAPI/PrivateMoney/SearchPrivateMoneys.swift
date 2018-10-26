import APIKit

public extension BankAPI.PrivateMoney {
    public struct Search: BankRequest {
        public let name: String?
        public let includeExclusive: Bool
        public let before: String?
        public let after: String?
        public let perPage: Int32?

        public typealias Response = PaginatedPrivateMoneys

        public init(name: String? = nil, includeExclusive: Bool = false, before: String? = nil, after: String? = nil, perPage: Int32? = nil) {
            self.name = name
            self.includeExclusive = includeExclusive
            self.before = before
            self.after = after
            self.perPage = perPage
        }

        public var method: HTTPMethod {
            return .get
        }

        public var path: String {
            return "/private-moneys"
        }

        public var parameters: Any? {
            var dict: [String: Any] = [:]
            if name != nil {
                dict["name"] = name
            }
            dict["include_exclusive"] = includeExclusive
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
