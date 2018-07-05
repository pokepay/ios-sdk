import APIKit

public extension BankAPI.Transaction {
    public struct CreateWillBill: BankRequest {
        public let billId: String
        public let accountId: String?
        public let amount: Double?

        public typealias Response = UserTransaction

        public init(billId: String, accountId: String?, amount: Double?) {
            self.billId = billId
            self.accountId = accountId
            self.amount = amount
        }

        public var method: HTTPMethod {
            return .post
        }

        public var path: String {
            return "/transactions"
        }

        public var parameters: Any? {
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
