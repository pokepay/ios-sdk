import APIKit

public extension BankAPI.Terminal {
    struct Get: BankRequest {
        public typealias Response = Terminal

        public init() {}

        public var method: HTTPMethod {
            return .get
        }

        public var path: String {
            return "/terminal"
        }
    }
}
