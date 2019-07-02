import APIKit

public extension BankAPI.Check {
    struct Create: BankRequest {
        public let amount: Double?
        public let accountId: String?
        public let description: String?

        public typealias Response = Check

        public init(amount: Double? = nil, accountId: String? = nil, description: String? = nil) {
            self.amount = amount
            self.accountId = accountId
            self.description = description
        }

        public var method: HTTPMethod {
            return .post
        }

        public var path: String {
            return "/checks"
        }

        public var parameters: Any? {
            var dict: [String: Any] = [:]
            if amount != nil {
                dict["amount"] = amount
            }
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
