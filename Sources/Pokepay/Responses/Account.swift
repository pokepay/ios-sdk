import Foundation

public struct Account: Codable {
    public let id: String
    public let name: String
    public let balance: Double
    public let isSuspended: Bool
    public let privateMoney: PrivateMoney

    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case balance
        case isSuspended = "is_suspended"
        case privateMoney = "private_money"
    }
}
