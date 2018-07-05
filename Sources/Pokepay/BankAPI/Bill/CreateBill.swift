import APIKit

extension BankAPI.Bill {
    struct Create: BankRequest {
        let amount: Double?
        let accountId: String?
        let description: String?

        typealias Response = Bill

        init(amount: Double?, accountId: String?, description: String?) {
            self.amount = amount
            self.accountId = accountId
            self.description = description
        }

        var method: HTTPMethod {
            return .post
        }

        var path: String {
            return "/bills"
        }

        var parameters: Any? {
            var dict: [String: Any] = ["amount": amount as Any]
            if accountId != nil {
                dict["account_id"] = accountId
            }
            if description != nil {
                dict["description"] = description
            }
            return dict
        }
    }
}
