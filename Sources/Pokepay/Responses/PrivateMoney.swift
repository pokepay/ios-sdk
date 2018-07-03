import Foundation

struct PrivateMoney: Codable {
    let id: String
    let name: String
    let organization: Organization
    let maxBalance: Double
    let expirationType: String

    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case organization
        case maxBalance = "max_balance"
        case expirationType = "expiration_type"
    }
}
