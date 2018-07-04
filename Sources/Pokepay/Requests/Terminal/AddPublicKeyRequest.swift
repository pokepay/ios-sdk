import APIKit

struct AddPublicKeyRequest: PokepayRequest {
    let key: String

    typealias Response = NoContent

    init(key: String) {
        self.key = key
    }

    var method: HTTPMethod {
        return .post
    }

    var path: String {
        return "/terminal/keys"
    }

    var parameters: Any? {
        return [
          "key": self.key
        ]
    }
}
