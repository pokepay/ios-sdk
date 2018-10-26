import Foundation

public struct UserTransaction: Codable {
    public let id: String
    public let user: User
    public let balance: Double
    public let amount: Double
    public let moneyAmount: Double
    public let pointAmount: Double
    public let account: Account
    public let description: String
    public let doneAt: String

    private enum CodingKeys: String, CodingKey {
        case id
        case user
        case balance
        case amount
        case moneyAmount = "money_amount"
        case pointAmount = "point_amount"
        case account
        case description
        case doneAt = "done_at"
    }
}
