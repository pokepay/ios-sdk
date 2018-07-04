import APIKit

struct GetTransaction: PokepayRequest {
    let id: String

    typealias Response = UserTransaction

    init(id: String) {
        self.id = id
    }

    var method: HTTPMethod {
        return .get
    }

    var path: String {
        return "/transactions/\(id)"
    }
}
