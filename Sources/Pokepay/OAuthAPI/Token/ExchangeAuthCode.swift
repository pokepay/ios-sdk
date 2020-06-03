import APIKit

public extension OAuthAPI.Token {
    struct ExchangeAuthCode: OAuthAPIRequest {
        public let code: String
        public let clientId: String
        public let clientSecret: String
        public let grantType: String

        public typealias Response = AccessToken

        public init(code: String, clientId: String, clientSecret: String, grantType: String = "authorization_code") {
            self.code = code
            self.clientId = clientId
            self.clientSecret = clientSecret
            self.grantType = grantType
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
