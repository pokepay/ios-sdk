import APIKit

public extension BankAPI.PrivateMoney {

    struct GetPrivateMoney: BankRequest {
        public let privateMoneyId:String

        public typealias Response = PrivateMoney

        public init(privateMoneyId: String) {
            self.privateMoneyId = privateMoneyId
        }

        public var method: HTTPMethod {
            return .get
        }

        public var path: String {
            return "/private-moneys/\(privateMoneyId)"
        }

        public var parameters: Any? {
            return [:]
        }

    }

}
