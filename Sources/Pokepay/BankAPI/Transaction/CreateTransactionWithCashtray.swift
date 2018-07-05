import APIKit

extension BankAPI.Transaction {
    struct CreateWillCashtray: BankRequest {
        let cashtrayId: String
        let accountId: String?

        typealias Response = UserTransaction

        init(cashtrayId: String, accountId: String?) {
            self.cashtrayId = cashtrayId
            self.accountId = accountId
        }

        var method: HTTPMethod {
            return .post
        }

        var path: String {
            return "/transactions"
        }

        var parameters: Any? {
            var dict = ["cashtray_id": cashtrayId]
            if accountId != nil {
                dict["account_id"] = accountId
            }
            return dict
        }
    }
}
