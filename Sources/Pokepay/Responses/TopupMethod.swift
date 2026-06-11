import Foundation

public struct TopupMethod: Codable {
    public static let typeCreditCard = "credit-card"

    public let type: String
    public let name: String
    public let amounts: [Double]?
    public let range: [Double]?

    public var isCreditCard: Bool {
        return type == TopupMethod.typeCreditCard
    }
}
