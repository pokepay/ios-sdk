import Foundation

public struct APIError: Codable {
    public let type: String
    public let message: String
}

public struct OAuthError: Codable {
    public let error: String
}
