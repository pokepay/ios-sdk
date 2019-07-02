import APIKit

public extension BankAPI.CpmToken {
    struct Get: BankRequest {
        public let cpmToken: String

        public typealias Response = AccountCpmToken

        public init(cpmToken: String) {
            self.cpmToken = cpmToken
        }

        public var method: HTTPMethod {
            return .get
        }

        public var path: String {
            return "/cpm/\(cpmToken)"
        }
    }
}
