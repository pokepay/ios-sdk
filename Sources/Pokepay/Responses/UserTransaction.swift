import Foundation

public struct UserTransaction: Codable {
    public let id: String
    public let type: String
    public let isModified: Bool
    public let user: User
    public let balance: Double
    public let customerBalance: Double
    public let amount: Double
    public let moneyAmount: Double
    public let pointAmount: Double
    public let account: Account
    public let description: String
    public let doneAt: Date

    private enum CodingKeys: String, CodingKey {
        case id
        case type
        case isModified = "is_modified"
        case user
        case balance
        case customerBalance = "customer_balance"
        case amount
        case moneyAmount = "money_amount"
        case pointAmount = "point_amount"
        case account
        case description
        case doneAt = "done_at"
    }
}
