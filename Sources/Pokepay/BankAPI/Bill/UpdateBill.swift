import APIKit

public extension BankAPI.Bill {
    @available(*, deprecated, message: "Use Autogen.BankAPI.Bill.UpdateBill instead. This hand-written request is being replaced by the auto-generated Autogen API.")
    struct Update: BankRequest {
        public let id: String
        public let amount: Double?
        public let description: String?

        public typealias Response = Bill

        public init(id: String, amount: Double? = nil, description: String? = nil) {
            self.id = id
            self.amount = amount
            self.description = description
        }

        public var method: HTTPMethod {
            return .patch
        }

        public var path: String {
            return "/bills/\(id)"
        }

        public var parameters: Any? {
            // 'amount' will be sent anyway even when it's nil (unsetting it)
            var dict: [String: Any] = ["amount": amount as Any]
            if description != nil {
                dict["description"] = description
            }
            return dict
        }
    }
}
