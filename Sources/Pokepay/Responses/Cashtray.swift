import Foundation

public struct Cashtray: Codable {
    public let id: String
    public let amount: Double
    public let description: String
    public let user: User
    public let privateMoney: PrivateMoney
    public let expiresAt: Date
    public let canceledAt: Date?
    public let token: String
    public let attempt: CashtrayAttempt?
    public let transaction: UserTransaction?

    private enum CodingKeys: String, CodingKey {
        case id
        case amount
        case description
        case user
        case privateMoney = "private_money"
        case expiresAt = "expires_at"
        case canceledAt = "canceled_at"
        case token
        case attempt
        case transaction
    }
}
