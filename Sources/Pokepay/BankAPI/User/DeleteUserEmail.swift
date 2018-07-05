import APIKit

extension BankAPI.User {
    struct DeleteEmail: BankRequest {
        let id: String
        let email: String

        typealias Response = NoContent

        init(id: String, email: String) {
            self.id = id
            self.email = email
        }

        var method: HTTPMethod {
            return .delete
        }

        var path: String {
            return "/users/\(id)/emails/\(email)"
        }
    }
}
