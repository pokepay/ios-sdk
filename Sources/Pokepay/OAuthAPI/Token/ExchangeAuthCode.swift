import APIKit

public extension OAuthAPI.Token {
    struct ExchangeAuthCode: OAuthAPIRequest {
        public let code: String
        public let grantType: String = "authorization_code"
        public let clientId: String
        public let clientSecret: String

        public typealias Response = AccessToken

        public init(code: String, clientId: String, clientSecret: String) {
            self.code = code
            self.clientId = clientId
            self.clientSecret = clientSecret
        }

        public var method: HTTPMethod {
            return .post
        }

        public var path: String {
            return "/oauth/token"
        }

        public var parameters: Any? {
            return [
              "code": code,
              "grant_type": grantType,
              "client_id": clientId,
              "client_secret": clientSecret
            ]
        }
    }
}
