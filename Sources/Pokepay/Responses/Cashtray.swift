import Foundation

public struct Cashtray: Codable {
    public let id: String
    public let amount: Double
    public let description: String
    public let user: User
    public let expiresAt: Date
    public let canceledAt: Date?
    public let token: String

    private enum CodingKeys: String, CodingKey {
        case id
        case amount
        case description
        case user
        case expiresAt = "expires_at"
        case canceledAt = "canceled_at"
        case token
    }
}
