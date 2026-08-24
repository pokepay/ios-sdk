import Foundation

public struct UserTagGroup: Codable {
    public let groupName: String
    public let id: String
    public let hasSubgroups: Bool

    private enum CodingKeys: String, CodingKey {
        case groupName = "group_name"
        case id = "id"
        case hasSubgroups = "has_subgroups"
    }
}
