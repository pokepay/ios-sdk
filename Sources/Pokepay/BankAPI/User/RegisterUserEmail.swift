import APIKit

extension BankAPI.User {
    struct RegisterEmail: BankRequest {
        let token: String

        typealias Response = NoContent

        init(token: String) {
            self.token = token
        }

        var method: HTTPMethod {
            return .post
        }

        var path: String {
            return "/emails"
        }
    }
}
