import APIKit

struct MakeTransactionWithCashtray: PokepayRequest {
    let id: String
    let accountId: String?

    typealias Response = UserTransaction

    init(id: String, accountId: String?) {
        self.id = id
        self.accountId = accountId
    }

    var method: HTTPMethod {
        return .post
    }

    var path: String {
        return "/transactions"
    }

    var parameters: Any? {
        var dict = ["cashtray_id": id]
        if accountId != nil {
            dict["account_id"] = accountId
        }
        return dict
    }
}
