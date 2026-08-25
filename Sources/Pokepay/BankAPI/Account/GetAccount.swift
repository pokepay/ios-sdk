import APIKit

public extension BankAPI.Account {
    @available(*, deprecated, message: "Use Autogen.BankAPI.Account.GetAccount instead. This hand-written request is being replaced by the auto-generated Autogen API.")
    struct Get: BankRequest {
        public let id: String

        public typealias Response = Account

        public init(id: String) {
            self.id = id
        }

        public var method: HTTPMethod {
            return .get
        }

        public var path: String {
            return "/accounts/\(id)"
        }
    }
}
