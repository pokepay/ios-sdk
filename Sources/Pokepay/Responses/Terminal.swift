import Foundation

struct Terminal: Codable {
    let id: String
    let name: String
    let hardwareId: String
    let pushToken: String?
    let user: User
    let account: Account

    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case hardwareId = "hardware_id"
        case pushToken = "push_token"
        case user
        case account
    }
}
