import Foundation

struct Cashtray: Codable {
    let id: String
    let amount: Double
    let description: String
    let user: User
    let expiresAt: String

    private enum CodingKeys: String, CodingKey {
        case id
        case amount
        case description
        case user
        case expiresAt = "expires_at"
    }
}
