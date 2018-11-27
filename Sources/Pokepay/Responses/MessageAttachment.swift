import Foundation

public struct MessageAttachment: Codable {
    public let moneyAmount: Double
    public let pointAmount: Double
    public let privateMoney: PrivateMoney
    public let isReceived: Bool
    public let expiresAt: Date

    private enum CodingKeys: String, CodingKey {
        case moneyAmount = "money_amount"
        case pointAmount = "point_amount"
        case privateMoney = "private_money"
        case isReceived = "is_received"
        case expiresAt = "expires_at"
    }
}
