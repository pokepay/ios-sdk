import APIKit

public extension OAuthAPI.Token {
    struct RefreshAccessToken: OAuthAPIRequest {
        public let refreshToken: String
        public let clientId: String
        public let clientSecret: String
        public let grantType: String

        public typealias Response = AccessToken

        public init(refreshToken: String, clientId: String, clientSecret: String, grantType: String = "refresh_token") {
            self.refreshToken = refreshToken
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
              "refresh_token": refreshToken,
              "grant_type": grantType,
              "client_id": clientId,
              "client_secret": clientSecret
            ]
        }
    }
}
