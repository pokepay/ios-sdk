import APIKit

public extension BankAPI.Terminal {
    @available(*, deprecated, message: "Use Autogen.BankAPI.Terminal.GetTerminal instead. This hand-written request is being replaced by the auto-generated Autogen API.")
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
