import APIKit

public extension BankAPI.Cvs {
    @available(*, deprecated, message: "Use Autogen.BankAPI.Cvs.GetCvsAuthorizations instead. This hand-written request is being replaced by the auto-generated Autogen API.")
    struct GetCvsAuthorizations: BankRequest {
        public let accountId: String
        public let before: String?
        public let after: String?
        public let perPage: Int?

        public typealias Response = PaginatedCvsAuthorizations

        public init(accountId: String, before: String? = nil, after: String? = nil, perPage: Int? = nil) {
            self.accountId = accountId
            self.before = before
            self.after = after
            self.perPage = perPage
        }

        public var method: HTTPMethod {
            return .get
        }

        public var path: String {
            return "/accounts/\(accountId)/cvs"
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
