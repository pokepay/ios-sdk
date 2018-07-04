import APIKit

struct GetAccountRequest: PokepayRequest {
    let id: String

    typealias Response = Account

    init(id: String) {
        self.id = id
    }

    var method: HTTPMethod {
        return .get
    }

    var path: String {
        return "/accounts/\(id)"
    }
}
