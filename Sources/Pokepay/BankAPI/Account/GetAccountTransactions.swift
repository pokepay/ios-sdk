import APIKit

extension BankAPI.Account {
    struct GetTransactions: BankRequest {
        let id: String
        let before: String?
        let after: String?
        let perPage: Int32?

        typealias Response = PaginatedTransactions

        init(id: String, before: String?, after: String?, perPage: Int32?) {
            self.id = id
            self.before = before
            self.after = after
            self.perPage = perPage
        }

        var method: HTTPMethod {
            return .get
        }

        var path: String {
            return "/accounts/\(id)/transactions"
        }

        var parameters: Any? {
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
