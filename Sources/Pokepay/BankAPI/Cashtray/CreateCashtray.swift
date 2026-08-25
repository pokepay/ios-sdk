import APIKit

public extension BankAPI.Cashtray {
    @available(*, deprecated, message: "Use Autogen.BankAPI.Cashtray.CreateCashtray instead. This hand-written request is being replaced by the auto-generated Autogen API.")
    struct Create: BankRequest {
        public let amount: Double
        public let description: String?
        public let expiresIn: Int32?
        public let products: [Product]?

        public typealias Response = Cashtray

        public init(amount: Double, description: String? = nil, expiresIn: Int32? = nil, products: [Product]? = nil) {
            self.amount = amount
            self.description = description
            self.expiresIn = expiresIn
            self.products = products
        }

        public var method: HTTPMethod {
            return .post
        }

        public var path: String {
            return "/cashtrays"
        }

        public var parameters: Any? {
            var dict: [String: Any] = ["amount": amount as Any]
            if description != nil {
                dict["description"] = description
            }
            if expiresIn != nil {
                dict["expires_in"] = expiresIn
            }
            if products != nil {
                dict["products"] = products!.map { $0.dictionary }
            }
            return dict
        }
    }
}
