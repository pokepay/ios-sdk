import Foundation

struct UserTransaction: Codable {
    let id: String
    let user: User
    let balance: Double
    let amount: Double
    let moneyAmount: Double
    let pointAmount: Double
    let description: String
    let doneAt: String

    private enum CodingKeys: String, CodingKey {
        case id
        case user
        case balance
        case amount
        case moneyAmount = "money_amount"
        case pointAmount = "point_amount"
        case description
        case doneAt = "done_at"
    }
}
