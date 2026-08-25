import APIKit

public extension BankAPI.Shop {
    @available(*, deprecated, message: "Use Autogen.BankAPI.Shop.GetDetailedShopInformation instead. This hand-written request is being replaced by the auto-generated Autogen API.")
    struct GetDetailedShopInformation: BankRequest {
        public let shopId: String

        public typealias Response = DetailedShopInformation

        public init(shopId: String) {
            self.shopId = shopId
        }

        public var method: HTTPMethod {
            return .get
        }

        public var path: String {
            return "/shops/\(shopId)"
        }

        public var parameters: Any? {
            var dict: [String: Any] = [:]

            return dict
        }
    }
}
