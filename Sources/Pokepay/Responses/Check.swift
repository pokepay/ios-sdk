import Foundation

public struct Check: Codable {
    public let id: String
    public let amount: Double
    public let moneyAmount: Double
    public let pointAmount: Double
    public let description: String
    public let user: User
    public let privateMoney: PrivateMoney
    public let isOnetime: Bool
    public let isDisabled: Bool
    public let expiresAt: Date
    public let token: String

    private enum CodingKeys: String, CodingKey {
        case id
        case amount
        case moneyAmount = "money_amount"
        case pointAmount = "point_amount"
        case description
        case user
        case privateMoney = "private_money"
        case isOnetime = "is_onetime"
        case isDisabled = "is_disabled"
        case expiresAt = "expires_at"
        case token
    }
}
