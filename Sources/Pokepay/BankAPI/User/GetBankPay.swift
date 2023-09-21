import APIKit

public extension BankAPI.User {
    struct GetBankPay: BankRequest {
        public let id: String
        public let privateMoneyId: String?

        public typealias Response = [BankPay]

        public init(id: String, privateMoneyId: String? = nil) {
            self.id = id
            self.privateMoneyId = privateMoneyId
        }

        public var method: HTTPMethod {
            return .get
        }

        public var path: String {
            return "/users/\(id)/banks"
        }

        public var parameters: Any? {
            var dict: [String: Any] = [:]

            if privateMoneyId != nil {
                dict["private_money_id"] = privateMoneyId
            }

            return dict
        }
    }
}
