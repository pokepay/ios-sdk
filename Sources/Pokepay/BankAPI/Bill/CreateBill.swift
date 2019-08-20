import APIKit

public extension BankAPI.Bill {
    struct Create: BankRequest {
        public let amount: Double?
        public let accountId: String?
        public let description: String?
        public let products: [Product]?

        public typealias Response = Bill

        public init(amount: Double? = nil, accountId: String? = nil, description: String? = nil, products: [Product]? = nil) {
            self.amount = amount
            self.accountId = accountId
            self.description = description
            self.products = products
        }

        public var method: HTTPMethod {
            return .post
        }

        public var path: String {
            return "/bills"
        }

        public var parameters: Any? {
            var dict: [String: Any] = ["amount": amount as Any]
            if accountId != nil {
                dict["account_id"] = accountId
            }
            if description != nil {
                dict["description"] = description
            }
            if products != nil {
                dict["products"] = products!.map { $0.dictionary }
            }
            return dict
        }
    }
}
