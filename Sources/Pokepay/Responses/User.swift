import Foundation

struct User: Codable {
    let id: String
    let name: String
    let isMerchant: Bool

    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case isMerchant = "is_merchant"
    }
}
