import APIKit

extension BankAPI.Transaction {
    struct CreateWillBill: BankRequest {
        let billId: String
        let accountId: String?
        let amount: Double?

        typealias Response = UserTransaction

        init(billId: String, accountId: String?, amount: Double?) {
            self.billId = billId
            self.accountId = accountId
            self.amount = amount
        }

        var method: HTTPMethod {
            return .post
        }

        var path: String {
            return "/transactions"
        }

        var parameters: Any? {
            var dict: [String: Any] = ["bill_id": billId]
            if accountId != nil {
                dict["account_id"] = accountId
            }
            if amount != nil {
                dict["amount"] = amount
            }
            return dict
        }
    }
}
