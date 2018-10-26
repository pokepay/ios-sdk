import Foundation

public struct AccountBalance: Codable {
    public let expiresAt: String
    public let moneyAmount: Double
    public let pointAmount: Double

    private enum CodingKeys: String, CodingKey {
        case expiresAt = "expires_at"
        case moneyAmount = "money_amount"
        case pointAmount = "point_amount"
    }
}
