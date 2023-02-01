import APIKit
import Foundation

public extension BankAPI.Transaction {
    struct CreateWithBill: BankRequest {
        public let billId: String
        public let accountId: String?
        public let amount: Double?
        public let couponId:String?
        public let strategy: TransactionStrategy?
        public let requestId: UUID?
        
        public typealias Response = UserTransaction

        public init(billId: String, accountId: String? = nil, amount: Double? = nil, couponId:String? = nil, strategy:TransactionStrategy? = .pointPreferred,
                    requestId: UUID? = nil) {
            self.requestId = requestId
            self.billId = billId
            self.accountId = accountId
            self.amount = amount
            self.couponId = couponId
            self.strategy = strategy
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
            if couponId != nil {
                dict["coupon_id"] = couponId
            }
            if strategy != nil {
                dict["strategy"] = strategy?.rawValue
            }
            if requestId != nil {
                dict["request_id"] = requestId?.uuidString
            }
            return dict
        }
    }
}
