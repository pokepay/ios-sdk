import APIKit
import Foundation

public extension BankAPI.Transaction {
    struct CreateWithCpm: BankRequest {
        public let cpmToken: String
        public let accountId: String?
        public let amount: Double
        public let products: [Product]?
        public let requestId: UUID?

        public typealias Response = UserTransaction

        public init(cpmToken: String, accountId: String? = nil, amount: Double, products: [Product]? = nil, requestId: UUID? = nil) {
            self.requestId = requestId
            self.cpmToken = cpmToken
            self.accountId = accountId
            self.amount = amount
            self.products = products
        }

        public var method: HTTPMethod {
            return .post
        }

        public var path: String {
            return "/transactions"
        }

        public var parameters: Any? {
            var dict: [String: Any] = ["cpm_token": cpmToken]
            if accountId != nil {
                dict["account_id"] = accountId
            }
            
            dict["amount"] = amount
            
            if products != nil {
                dict["products"] = products!.map { $0.dictionary }
            }
            if requestId != nil {
                dict["request_id"] = requestId?.uuidString
            }
            return dict
        }
    }
}
