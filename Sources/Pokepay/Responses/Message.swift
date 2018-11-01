import Foundation

public struct Message: Codable {
    public let id: String
    public let subject: String
    public let body: String
    public let fromUser: User
    public let toUser: User
    public let isUnread: Bool
    public let attachment: MessageAttachment

    private enum CodingKeys: String, CodingKey {
        case id
        case subject
        case body
        case fromUser = "from_user"
        case toUser = "to_user"
        case isUnread = "is_unread"
        case attachment
    }
}
