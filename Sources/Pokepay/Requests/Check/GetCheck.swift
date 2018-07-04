import APIKit

struct GetCheck: PokepayRequest {
    let id: String

    typealias Response = Check

    init(id: String) {
        self.id = id
    }

    var method: HTTPMethod {
        return .get
    }

    var path: String {
        return "/checks/\(id)"
    }
}
