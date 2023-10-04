import Foundation

public struct AccountCampaignPointAmounts: Codable {
    public let maxTotalPointAmount: Double?
    public let totalPointAmount: Double?
    public let remainPointAmount: Double?

    private enum CodingKeys: String, CodingKey {
        case maxTotalPointAmount = "max_total_point_amount"
        case totalPointAmount = "total_point_amount"
        case remainPointAmount = "remain_point_amount"
    }
}
