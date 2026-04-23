import Foundation

public struct AccountTopupQuotas: Codable {
    public let rows: [AccountTopupQuota]

    private enum CodingKeys: String, CodingKey {
        case rows = "rows"
    }
}
