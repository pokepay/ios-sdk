import Foundation

public struct Cashtray: Codable {
    public let id: String
    public let amount: Double
    public let description: String
    public let user: User
    public let expiresAt: Date

    private enum CodingKeys: String, CodingKey {
        case id
        case amount
        case description
        case user
        case expiresAt = "expires_at"
    }
}
