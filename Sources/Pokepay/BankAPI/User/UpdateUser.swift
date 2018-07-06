import APIKit

public extension BankAPI.User {
    public struct Update: BankRequest {
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
