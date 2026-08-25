import APIKit

public extension BankAPI.Cvs {
    @available(*, deprecated, message: "Use Autogen.BankAPI.Cvs.CancelCvsAuthorization instead. This hand-written request is being replaced by the auto-generated Autogen API.")
    struct CancelCvsAuthorization: BankRequest {
        public let accountId: String
        public let orderId: String

        public typealias Response = NoContent

        public init(accountId: String, orderId: String) {
            self.accountId = accountId
            self.orderId = orderId
        }

        public var method: HTTPMethod {
            return .delete
        }

        public var path: String {
            return "/accounts/\(accountId)/cvs/\(orderId)"
        }

        public var parameters: Any? {
            var dict: [String: Any] = [:]

            return dict
        }
    }
}
