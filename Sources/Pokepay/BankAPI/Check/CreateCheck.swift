import APIKit

public extension BankAPI.Check {
    public struct Create: BankRequest {
        public let amount: Double?
        public let accountId: String?
        public let description: String?

        public typealias Response = Check

        public init(amount: Double?, accountId: String?, description: String?) {
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
