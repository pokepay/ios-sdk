import APIKit

public extension BankAPI.Account {
    struct CreateAccountCpmToken: BankRequest {

        public enum Scope: Int {
            case PAYMENT = 1
            case TOPUP = 2
            case BOTH = 3
        }

        public let accountId: String
        public let scopes: Scope
        public let expiresIn: Int?
        public let additionalInfo: String?

        public typealias Response = AccountCpmToken

        public init(accountId: String, scopes: Scope = .PAYMENT, expiresIn: Int? = nil, additionalInfo: String? = nil) {
            self.accountId = accountId
            self.scopes = scopes
            self.expiresIn = expiresIn
            self.additionalInfo = additionalInfo
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
            if (scopes.rawValue & Scope.PAYMENT.rawValue) != 0 {
                scopesArr.append("payment")
            }
            if (scopes.rawValue & Scope.TOPUP.rawValue) != 0 {
                scopesArr.append("topup")
            }
            dict["scopes"] = scopesArr
            if expiresIn != nil {
                dict["expires_in"] = expiresIn
            }
            if additionalInfo != nil {
                dict["additional_info"] = additionalInfo
            }
            return dict
        }
    }
}
