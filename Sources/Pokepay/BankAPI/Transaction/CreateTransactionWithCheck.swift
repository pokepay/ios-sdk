import APIKit

extension BankAPI.Transaction {
    struct CreateWillCheck: BankRequest {
        let checkId: String
        let accountId: String?

        typealias Response = UserTransaction

        init(checkId: String, accountId: String?) {
            self.checkId = checkId
            self.accountId = accountId
        }

        var method: HTTPMethod {
            return .post
        }

        var path: String {
            return "/transactions"
        }

        var parameters: Any? {
            var dict = ["check_id": checkId]
            if accountId != nil {
                dict["account_id"] = accountId
            }
            return dict
        }
    }
}
