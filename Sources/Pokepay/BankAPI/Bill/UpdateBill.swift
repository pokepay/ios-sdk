import APIKit

extension BankAPI.Bill {
    struct Update: BankRequest {
        let id: String
        let amount: Double?
        let description: String?

        typealias Response = Bill

        init(id: String, amount: Double?, description: String?) {
            self.id = id
            self.amount = amount
            self.description = description
        }

        var method: HTTPMethod {
            return .patch
        }

        var path: String {
            return "/bills/\(id)"
        }

        var parameters: Any? {
            // 'amount' will be sent anyway even when it's nil (unsetting it)
            var dict: [String: Any] = ["amount": amount as Any]
            if description != nil {
                dict["description"] = description
            }
            return dict
        }
    }
}
