import APIKit

struct MakeCheck: PokepayRequest {
    let amount: Double?
    let accountId: String?
    let description: String?

    typealias Response = Check

    init(amount: Double?, accountId: String?, description: String?) {
        self.amount = amount
        self.accountId = accountId
        self.description = description
    }

    var method: HTTPMethod {
        return .post
    }

    var path: String {
        return "/checks"
    }

    var parameters: Any? {
        var dict: [String: Any] = [:]
        if amount != nil {
            dict["amount"] = amount
        }
        if accountId != nil {
            dict["account_id"] = accountId
        }
        if description != nil {
            dict["description"] = description
        }
        return dict
    }
}
