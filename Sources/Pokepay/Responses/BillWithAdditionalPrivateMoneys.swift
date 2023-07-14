import Foundation

public struct BillWithAdditionalPrivateMoneys: Codable {
    public let id: String
    public let amount: Double?
    public let description: String
    public let user: User
    public let privateMoney: PrivateMoney
    public let isOnetime: Bool
    public let isDisabled: Bool
    public let token: String
    public let minAmount: Double?
    public let maxAmount: Double?
    public let additionalPrivateMoneys: [PrivateMoney]

    private enum CodingKeys: String, CodingKey {
        case id
        case amount
        case description
        case user
        case privateMoney = "private_money"
        case isOnetime = "is_onetime"
        case isDisabled = "is_disabled"
        case token
        case minAmount = "min_amount"
        case maxAmount = "max_amount"
        case additionalPrivateMoneys = "additional_private_moneys"
    }
}
