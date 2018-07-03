import Foundation

struct Account: Codable {
    let id: String
    let name: String
    let balance: Double
    let isSuspended: Bool
    let privateMoney: PrivateMoney

    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case balance
        case isSuspended = "is_suspended"
        case privateMoney = "private_money"
    }
}
