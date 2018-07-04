import APIKit

struct UpdateCheckRequest: PokepayRequest {
    let id: String
    let amount: Double?
    let description: String?

    typealias Response = Check

    init(id: String, amount: Double?, description: String?) {
        self.id = id
        self.amount = amount
        self.description = description
    }

    var method: HTTPMethod {
        return .patch
    }

    var path: String {
        return "/checks/\(id)"
    }

    var parameters: Any? {
        var dict: [String: Any] = [:]
        if amount != nil {
            dict["amount"] = amount
        }
        if description != nil {
            dict["description"] = description
        }
        return dict
    }
}
