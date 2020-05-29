import Foundation

public struct Card: Codable {
    public let card_number: String
    public let registeredAt: String

    private enum CodingKeys: String, CodingKey {
        case card_number
        case registeredAt = "registered_at"
    }
}
