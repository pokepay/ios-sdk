import APIKit

public extension BankAPI.Transaction {
    @available(*, deprecated, message: "Use Autogen.BankAPI.Transaction.GetTransactionByRequestId instead. This hand-written request is being replaced by the auto-generated Autogen API.")
    struct GetTransactionByRequestId: BankRequest {
        public let requestId: String

        public typealias Response = UserTransactionWithTransfers

        public init(requestId: String) {
            self.requestId = requestId
        }

        public var method: HTTPMethod {
            return .get
        }

        public var path: String {
            return "/transactions/requests/\(requestId)"
        }

        public var parameters: Any? {
            var dict: [String: Any] = [:]

            return dict
        }
    }
}
