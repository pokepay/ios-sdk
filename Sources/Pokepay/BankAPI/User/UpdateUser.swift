import APIKit

public extension BankAPI.User {
    @available(*, deprecated, message: "Use Autogen.BankAPI.User.UpdateUser instead. This hand-written request is being replaced by the auto-generated Autogen API.")
    struct Update: BankRequest {
        public let id: String
        public let name: String?

        public typealias Response = User

        public init(id: String, name: String? = nil) {
            self.id = id
            self.name = name
        }

        public var method: HTTPMethod {
            return .patch
        }

        public var path: String {
            return "/users/\(id)"
        }

        public var parameters: Any? {
            var dict: [String: Any] = [:]
            if name != nil {
                dict["name"] = name
            }
            return dict
        }
    }
}
