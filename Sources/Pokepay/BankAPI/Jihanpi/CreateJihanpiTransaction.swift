import APIKit

public extension BankAPI.Jihanpi {
    @available(*, deprecated, message: "Use Autogen.BankAPI.Jihanpi.CreateJihanpiTransaction instead. This hand-written request is being replaced by the auto-generated Autogen API.")
    struct CreateJihanpiTransaction: BankRequest {
        public let nfcTagId: String
        public let accountId: String
        public let requestId: String?
        public let strategy: String?

        public typealias Response = JihanpiTransaction

        public init(nfcTagId: String, accountId: String, requestId: String? = nil, strategy: String? = nil) {
            self.nfcTagId = nfcTagId
            self.accountId = accountId
            self.requestId = requestId
            self.strategy = strategy
        }

        public var method: HTTPMethod {
            return .post
        }

        public var path: String {
            return "/jihanpi-transactions"
        }

        public var parameters: Any? {
            var dict: [String: Any] = [:]

            dict["nfc_tag_id"] = nfcTagId

            dict["account_id"] = accountId

            if requestId != nil {
                dict["request_id"] = requestId
            }

            if strategy != nil {
                dict["strategy"] = strategy
            }

            return dict
        }
    }
}
