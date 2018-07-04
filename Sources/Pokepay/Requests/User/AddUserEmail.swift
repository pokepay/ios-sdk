import APIKit

struct AddUserEmailRequest: PokepayRequest {
    let id: String
    let email: String

    typealias Response = NoContent

    init(id: String, email: String) {
        self.id = id
        self.email = email
    }

    var method: HTTPMethod {
        return .put
    }

    var path: String {
        return "/users/\(id)/emails/\(email)"
    }
}
