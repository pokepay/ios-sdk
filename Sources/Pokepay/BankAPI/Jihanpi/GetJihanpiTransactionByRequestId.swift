import APIKit

public extension BankAPI.Jihanpi {
    @available(*, deprecated, message: "Use Autogen.BankAPI.Jihanpi.GetJihanpiTransactionByRequestId instead. This hand-written request is being replaced by the auto-generated Autogen API.")
    struct GetJihanpiTransactionByRequestId: BankRequest {
        public let requestId: String

        public typealias Response = JihanpiTransaction

        public init(requestId: String) {
            self.requestId = requestId
        }

        public var method: HTTPMethod {
            return .get
        }

        public var path: String {
            return "/jihanpi-transactions/requests/\(requestId)"
        }

        public var parameters: Any? {
            var dict: [String: Any] = [:]

            return dict
        }
    }
}
