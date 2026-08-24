import Foundation

public struct UserTagGroupItem: Codable {
    public let itemName: String
    public let id: String
    public let subgroupId: String?

    private enum CodingKeys: String, CodingKey {
        case itemName = "item_name"
        case id = "id"
        case subgroupId = "subgroup_id"
    }
}
