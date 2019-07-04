import APIKit

public extension BankAPI.Terminal {
    struct AddPublicKey: BankRequest {
        public let key: String

        public typealias Response = NoContent

        public init(key: String) {
            self.key = key
        }

        public var method: HTTPMethod {
            return .post
        }

        public var path: String {
            return "/terminal/keys"
        }

        public var parameters: Any? {
            return [
              "key": self.key
            ]
        }
    }
}
