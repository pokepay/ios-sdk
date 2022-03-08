import Foundation

public struct Transfer: Codable {
    public let id: String
    public let type: String
    public let amount: Double?
    public let balance: Double?
    public let description: String
    public let user: User?
    public let account: Account?
    public let doneAt: Date
    public let moneyAmount: Double
    public let pointAmount: Double
    public let transactionId: String?

    private enum CodingKeys: String, CodingKey {
        case id
        case type
        case amount
        case balance
        case description
        case user
        case account
        case doneAt = "done_at"
        case moneyAmount = "money_amount"
        case pointAmount = "point_amount"
        case transactionId = "transaction_id"
    }
}
