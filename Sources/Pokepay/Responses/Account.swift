import Foundation

public struct Account: Codable {
    public let id: String
    public let name: String
    public let balance: Double
    public let moneyBalance: Double
    public let pointBalance: Double
    public let isSuspended: Bool
    public let privateMoney: PrivateMoney
    public let nearestExpiresAt: String?

    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case balance
        case moneyBalance = "money_balance"
        case pointBalance = "point_balance"
        case isSuspended = "is_suspended"
        case privateMoney = "private_money"
        case nearestExpiresAt = "nearest_expires_at"
    }
}
