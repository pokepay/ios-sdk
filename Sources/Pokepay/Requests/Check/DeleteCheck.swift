import APIKit

struct DeleteCheckRequest: PokepayRequest {
    let id: String

    typealias Response = NoContent

    init(id: String) {
        self.id = id
    }

    var method: HTTPMethod {
        return .delete
    }

    var path: String {
        return "/checks/\(id)"
    }
}
