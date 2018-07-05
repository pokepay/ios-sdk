import APIKit

extension BankAPI.User {
    struct Update: BankRequest {
        let id: String
        let name: String?

        typealias Response = User

        init(id: String, name: String?) {
            self.id = id
            self.name = name
        }

        var method: HTTPMethod {
            return .patch
        }

        var path: String {
            return "/users/\(id)"
        }

        var parameters: Any? {
            var dict: [String: Any] = [:]
            if name != nil {
                dict["name"] = name
            }
            return dict
        }
    }
}
