import Foundation

public struct Terminal: Codable {
    public let id: String
    public let name: String
    public let hardwareId: String
    public let pushService: String?
    public let pushToken: String?
    public let user: User
    public let account: Account

    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case hardwareId = "hardware_id"
        case pushService = "push_service"
        case pushToken = "push_token"
        case user
        case account
    }
}
