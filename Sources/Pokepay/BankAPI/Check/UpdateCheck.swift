import APIKit

public extension BankAPI.Check {
    @available(*, deprecated, message: "Use Autogen.BankAPI.Check.UpdateCheck instead. This hand-written request is being replaced by the auto-generated Autogen API.")
    struct Update: BankRequest {
        public let id: String
        public let amount: Double?
        public let description: String?

        public typealias Response = Check

        public init(id: String, amount: Double? = nil, description: String? = nil) {
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
