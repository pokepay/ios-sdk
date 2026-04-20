import APIKit

public extension OAuthAPI.Token {
    struct TokenExchange: OAuthAPIRequest {
        public let grantType: String = "urn:ietf:params:oauth:grant-type:token-exchange"
        public let clientId: String?
        public let clientSecret: String?
        public let resource: String?
        public let audience: String?
        public let subjectToken: String
        public let subjectTokenType: String
        public let requestedTokenType: String
        public let scopes: [String]?
        public let actorTokenType: String?
        public let actorToken: String?

        public typealias Response = ExchangedToken

        public init(
          clientId: String?,
          clientSecret: String?,
          resource: String?,
          audience: String?,
          subjectToken: String,
          subjectTokenType: String,
          requestedTokenType: String,
          scopes: [String]?,
          actorTokenType: String?,
          actorToken: String?
        ) {
            self.clientId = clientId             
            self.clientSecret = clientSecret
            self.resource = resource
            self.audience = audience
            self.subjectToken = subjectToken
            self.subjectTokenType = subjectTokenType
            self.requestedTokenType = requestedTokenType
            self.scopes = scopes
            self.actorTokenType = actorTokenType
            self.actorToken = actorToken
        }

        public var method: HTTPMethod {
            return .post
        }

        public var path: String {
            return "/oauth/token"
        }

        public var parameters: Any? {
            return [
              "grant_type": grantType,            
              "client_id": clientId,              
              "client_secret": clientSecret,
              "resource": resource,
              "audience": audience,
              "subject_token": subjectToken,
              "subject_token_type": subjectTokenType,
              "requested_token_type": requestedTokenType,
              "scope": scopes?.joined(separator: " "),
              "actor_token_type": actorTokenType,
              "actor_token": actorToken,    
            ]
        }
    }
}
