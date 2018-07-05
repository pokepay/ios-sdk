import APIKit

extension BankAPI.Account {
    struct Create: BankRequest {
        let name: String?
        let privateMoneyId: String?

        typealias Response = Account

        init(name: String?, privateMoneyId: String?) {
            self.name = name
            self.privateMoneyId = privateMoneyId
        }

        var method: HTTPMethod {
            return .post
        }

        var path: String {
            return "/accounts"
        }

        var parameters: Any? {
            var dict: [String: Any] = [:]
            if name != nil {
                dict["name"] = name
            }
            if privateMoneyId != nil {
                dict["private_money_id"] = privateMoneyId
            }
            return dict
        }
    }
}
