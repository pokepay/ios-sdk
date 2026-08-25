import APIKit

public extension BankAPI.Account {
    @available(*, deprecated, message: "Use Autogen.BankAPI.Account.GetAccountIndividualNumberIdentification instead. This hand-written request is being replaced by the auto-generated Autogen API.")
    struct GetAccountIndividualNumberIdentification: BankRequest {
        public let accountId: String

        public typealias Response = IndividualNumberIdentificationStatus

        public init(accountId: String) {
            self.accountId = accountId
        }

        public var method: HTTPMethod {
            return .get
        }

        public var path: String {
            return "/accounts/\(accountId)/individual-numbers/identification"
        }

        public var parameters: Any? {
            var dict: [String: Any] = [:]

            return dict
        }
    }
}
