import APIKit

public extension OAuthAPI.Token {
    public struct RefreshAccessToken: OAuthAPIRequest {
        public let grantType: String = "refresh_token"
        public let refreshToken: String
        public let clientId: String
        public let clientSecret: String

        public typealias Response = AccessToken

        public init(refreshToken: String, clientId: String, clientSecret: String) {
            self.refreshToken = refreshToken
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
              "refresh_token": refreshToken,
              "grant_type": grantType,
              "client_id": clientId,
              "client_secret": clientSecret
            ]
        }
    }
}
