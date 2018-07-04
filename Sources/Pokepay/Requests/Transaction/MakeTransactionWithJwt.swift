import APIKit

struct MakeTransactionWithJwt: PokepayRequest {
    let data: String
    let accountId: String?

    typealias Response = UserTransaction

    init(data: String, accountId: String?) {
        self.data = data
        self.accountId = accountId
    }

    var method: HTTPMethod {
        return .post
    }

    var path: String {
        return "/transactions"
    }

    var parameters: Any? {
        var dict = ["data": data]
        if accountId != nil {
            dict["account_id"] = accountId
        }
        return dict
    }
}
