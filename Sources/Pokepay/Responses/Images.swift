import Foundation

public struct Images: Codable {
    public let card: String?
    public let res300: String?
    public let res600: String?

    private enum CodingKeys: String, CodingKey {
        case card
        case res300 = "300x300"
        case res600 = "600x600"
    }
}
