import APIKit

public extension BankAPI.Cashtray {
    public struct Update: BankRequest {
        public let id: String
        public let amount: Double?
        public let description: String?
        public let expiresIn: Int32?

        public typealias Response = Cashtray

        public init(id: String, amount: Double? = nil, description: String? = nil, expiresIn: Int32? = nil) {
            self.id = id
            self.amount = amount
            self.description = description
            self.expiresIn = expiresIn
        }

        public var method: HTTPMethod {
            return .patch
        }

        public var path: String {
            return "/cashtrays/\(id)"
        }

        public var parameters: Any? {
            var dict: [String: Any] = [:]
            if amount != nil {
                dict["amount"] = amount
            }
            if description != nil {
                dict["description"] = description
            }
            if expiresIn != nil {
                dict["expires_in"] = expiresIn
            }
            return dict
        }
    }
}
