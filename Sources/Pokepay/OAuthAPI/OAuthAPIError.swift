import Foundation

enum OAuthAPIError: Error {
    case invalidJSON(Swift.Error)
    case unknown
    case invalidRequest
    case invalidClient
    case invalidGrant
    case unauthorizedClient
    case unsupportedGrantType
    case invalidScope
    case unrecognizedClient
    case invalidRedirectUri
    case unsupportedResponseType

    init(object: Data) {
        do {
            let error = try JSONDecoder().decode(OAuthError.self, from: object)
            switch error.error {
            case "invalid_request": self = .invalidRequest
            case "invalid_client": self = .invalidClient
            case "invalid_grant": self = .invalidGrant
            case "unauthorized_client": self = .unauthorizedClient
            case "unsupported_grant_type": self  = .unsupportedGrantType
            case "invalid_scope": self = .invalidScope
            case "unrecognized_client": self = .unrecognizedClient
            case "invalid_redirect_uri": self = .invalidRedirectUri
            case "unsupported_response_type": self = .unsupportedResponseType
            default: self = .unknown
            }
        } catch let decodeError {
            self = .invalidJSON(decodeError)
            return
        }
    }
}
