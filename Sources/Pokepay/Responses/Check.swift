import Foundation

struct Check: Codable {
    let id: String
    let amount: Double
    let description: String
    let user: User
}
