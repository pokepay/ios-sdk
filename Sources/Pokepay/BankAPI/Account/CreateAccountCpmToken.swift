import APIKit

public extension BankAPI.Account {
    struct CreateAccountCpmToken: BankRequest {

        public enum Scope: Int {
            case PAYMENT = 1
            case TOPUP = 2
            case BOTH = 3
        }

        public let accountId: String
        public let scopes: Int
        public let expiresIn: Int?
        public let metadata: [String:String]?
        public let keepAlive: Bool?

        public typealias Response = AccountCpmToken

        public init(accountId: String, scopes: Scope = .PAYMENT, expiresIn: Int? = nil, metadata: [String:String]? = nil, keepAlive: Bool? = nil) {
            self.accountId = accountId
            self.scopes = scopes.rawValue
            self.expiresIn = expiresIn
            self.metadata = metadata
            self.keepAlive = keepAlive
        }
        
        public init(accountId: String, scopes: Int, expiresIn: Int? = nil, metadata: [String:String]? = nil, keepAlive: Bool? = nil){
            self.accountId = accountId
            self.scopes = scopes
            self.expiresIn = expiresIn
            self.metadata = metadata
            self.keepAlive = keepAlive
        }

        public var method: HTTPMethod {
            return .post
        }

        public var path: String {
            return "/accounts/\(accountId)/cpm"
        }

        public var parameters: Any? {
            var dict: [String: Any] = [:]
            var scopesArr: [String] = []

            if (scopes & Scope.PAYMENT.rawValue) != 0 {
                scopesArr.append("payment")
            }

            if (scopes & Scope.TOPUP.rawValue) != 0 {
                scopesArr.append("topup")
            }

            dict["scopes"] = scopesArr

            if expiresIn != nil {
                dict["expires_in"] = expiresIn
            }

            if metadata != nil {
                dict["metadata"] = self.toJsonString(metadata:metadata!)
            }

            if keepAlive != nil {
                dict["keep_alive"] = keepAlive
            }

            return dict
        }
        
        private func toJsonString(metadata:[String:String]) -> String{
            var jsonString = "{"
            for (key, value) in metadata {
                jsonString.append("\"")
                jsonString.append(key)
                jsonString.append("\":\"")
                jsonString.append(value)
                jsonString.append("\"")
                jsonString.append(",")
            }
            jsonString.removeLast()
            jsonString.append("}")
            return jsonString
        }
    }
}
