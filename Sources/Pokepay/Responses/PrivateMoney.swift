import Foundation

public struct PrivateMoney: Codable {
    public let id: String
    public let name: String
    public let organization: Organization
    public let maxBalance: Double
    public let expirationType: String

    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case organization
        case maxBalance = "max_balance"
        case expirationType = "expiration_type"
    }
}
