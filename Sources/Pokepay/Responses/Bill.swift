import Foundation

struct Bill: Codable {
    let id: String
    let amount: Double?
    let description: String
    let user: User
}
