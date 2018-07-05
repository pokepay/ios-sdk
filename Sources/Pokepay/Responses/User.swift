import Foundation

public struct User: Codable {
    public let id: String
    public let name: String
    public let isMerchant: Bool

    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case isMerchant = "is_merchant"
    }
}
