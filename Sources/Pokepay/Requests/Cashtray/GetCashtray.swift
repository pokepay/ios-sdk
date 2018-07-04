import APIKit

struct GetCashtrayRequest: PokepayRequest {
    let id: String

    typealias Response = Cashtray

    init(id: String) {
        self.id = id
    }

    var method: HTTPMethod {
        return .get
    }

    var path: String {
        return "/cashtrays/\(id)"
    }
}
