import Foundation

public struct UserTagSubgroup: Codable {
    public let subgroupName: String
    public let id: String

    private enum CodingKeys: String, CodingKey {
        case subgroupName = "subgroup_name"
        case id = "id"
    }
}
