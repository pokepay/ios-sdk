import APIKit

struct MakeCashtrayRequest: PokepayRequest {
    let amount: Double
    let description: String?
    let expiresIn: Int32?

    typealias Response = Cashtray

    init(amount: Double, description: String?, expiresIn: Int32?) {
        self.amount = amount
        self.description = description
        self.expiresIn = expiresIn
    }

    var method: HTTPMethod {
        return .post
    }

    var path: String {
        return "/cashtrays"
    }

    var parameters: Any? {
        var dict: [String: Any] = ["amount": amount as Any]
        if description != nil {
            dict["description"] = description
        }
        if expiresIn != nil {
            dict["expires_in"] = expiresIn
        }
        return dict
    }
}
