import APIKit

extension BankAPI.Terminal {
    struct Get: BankRequest {
        typealias Response = Terminal

        init() {}

        var method: HTTPMethod {
            return .get
        }

        var path: String {
            return "/terminal"
        }
    }
}
