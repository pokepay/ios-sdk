import APIKit

public extension BankAPI.Check {
    public struct Update: BankRequest {
        public let id: String
        public let amount: Double?
        public let description: String?

        public typealias Response = Check

        public init(id: String, amount: Double?, description: String?) {
            self.id = id
            self.amount = amount
            self.description = description
        }

        public var method: HTTPMethod {
            return .patch
        }

        public var path: String {
            return "/checks/\(id)"
        }

        public var parameters: Any? {
            var dict: [String: Any] = [:]
            if amount != nil {
                dict["amount"] = amount
            }
            if description != nil {
                dict["description"] = description
            }
            return dict
        }
    }
}
