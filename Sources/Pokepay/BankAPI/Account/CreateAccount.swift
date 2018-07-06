import APIKit

public extension BankAPI.Account {
    public struct Create: BankRequest {
        public let name: String?
        public let privateMoneyId: String?

        public typealias Response = Account

        public init(name: String? = nil, privateMoneyId: String? = nil) {
            self.name = name
            self.privateMoneyId = privateMoneyId
        }

        public var method: HTTPMethod {
            return .post
        }

        public var path: String {
            return "/accounts"
        }

        public var parameters: Any? {
            var dict: [String: Any] = [:]
            if name != nil {
                dict["name"] = name
            }
            if privateMoneyId != nil {
                dict["private_money_id"] = privateMoneyId
            }
            return dict
        }
    }
}
