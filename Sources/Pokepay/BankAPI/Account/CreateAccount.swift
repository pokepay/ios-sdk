import APIKit

public extension BankAPI.Account {
    struct Create: BankRequest {
        public let name: String?
        public let privateMoneyId: String?
        public let externalId: String?

        public typealias Response = Account

        public init(name: String? = nil, privateMoneyId: String? = nil, externalId: String? = nil) {
            self.name = name
            self.privateMoneyId = privateMoneyId
            self.externalId = externalId
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
            if externalId != nil {
                dict["external_id"] = externalId
            }
            return dict
        }
    }
}
