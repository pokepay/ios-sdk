import APIKit

public extension BankAPI.Jihanpi {
    @available(*, deprecated, message: "Use Autogen.BankAPI.Jihanpi.GetJihanpiTransactionByOrderId instead. This hand-written request is being replaced by the auto-generated Autogen API.")
    struct GetJihanpiTransactionByOrderId: BankRequest {
        public let orderId: String

        public typealias Response = JihanpiTransaction

        public init(orderId: String) {
            self.orderId = orderId
        }

        public var method: HTTPMethod {
            return .get
        }

        public var path: String {
            return "/jihanpi-transactions/\(orderId)"
        }

        public var parameters: Any? {
            var dict: [String: Any] = [:]

            return dict
        }
    }
}
