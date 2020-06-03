import Foundation

public enum OAuthAPIErrorType {
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
    init(error: String) {
        switch error {
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
    }
}

public enum OAuthAPIError: Error {
    case invalidJSON(Swift.Error)
    case unknownError(Int, OAuthError, OAuthAPIErrorType)
    case clientError(Int, OAuthError, OAuthAPIErrorType)
    case serverError(Int, OAuthError, OAuthAPIErrorType)

    init(statusCode: Int? = nil, object: Data) {
        do {
            let error = try JSONDecoder().decode(OAuthError.self, from: object)
            guard let code = statusCode else {
                self = .unknownError(0, error, OAuthAPIErrorType(error: error.error))
                return
            }
            if ((400..<500).contains(code)) {
                self = .clientError(code, error, OAuthAPIErrorType(error: error.error))
            }
            else if ((500..<600).contains(code)) {
                self = .serverError(code, error, OAuthAPIErrorType(error: error.error))
            }
            else {
                self = .unknownError(code, error, OAuthAPIErrorType(error: error.error))
            }
        } catch let decodeError {
            self = .invalidJSON(decodeError)
            return
        }
    }
}
