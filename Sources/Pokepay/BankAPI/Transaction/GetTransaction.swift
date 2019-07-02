import APIKit

public extension BankAPI.Transaction {
    struct Get: BankRequest {
        public let id: String

        public typealias Response = UserTransaction

        public init(id: String) {
            self.id = id
        }

        public var method: HTTPMethod {
            return .get
        }

        public var path: String {
            return "/transactions/\(id)"
        }
    }
}
