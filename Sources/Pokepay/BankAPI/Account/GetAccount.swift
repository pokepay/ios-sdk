import APIKit

public extension BankAPI.Account {
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
