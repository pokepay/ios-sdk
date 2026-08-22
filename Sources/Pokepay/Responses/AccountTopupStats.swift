import Foundation

public struct AccountTopupStats: Codable {
    public let currentAmount: Double
    public let limitAmount: Double
    public let remainingAmount: Double
    public let startedAt: String?

    private enum CodingKeys: String, CodingKey {
        case currentAmount = "current_amount"
        case limitAmount = "limit_amount"
        case remainingAmount = "remaining_amount"
        case startedAt = "started_at"
    }
}
