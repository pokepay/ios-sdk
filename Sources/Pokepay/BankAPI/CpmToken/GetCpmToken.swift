import APIKit

public extension BankAPI.CpmToken {
    @available(*, deprecated, message: "Use Autogen.BankAPI.Cpm.GetCpmToken instead. This hand-written request is being replaced by the auto-generated Autogen API.")
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
