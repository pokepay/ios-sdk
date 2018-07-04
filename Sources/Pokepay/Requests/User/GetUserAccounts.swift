import APIKit

struct GetUserAccountsRequest: PokepayRequest {
    let id: String
    let before: String?
    let after: String?
    let perPage: Int32?

    typealias Response = PaginatedAccounts

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
        return "/users/\(id)/accounts"
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
