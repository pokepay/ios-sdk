import Foundation

public struct ExchangedToken: Codable {
    public let accessToken: String
    public let issuedTokenType: String
    public let tokenType: String
    public let expiresIn: Int32?
    public let scope: String?
    public let refreshToken: String?

    public func scopes() -> [String] {
        return scope?.split(separator: " ").map(String.init) ?? []
    }

    private enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case issuedTokenType = "issued_token_type"
        case tokenType = "token_type"
        case expiresIn = "expires_in"
        case scope
        case refreshToken = "refresh_token"
    }
}
