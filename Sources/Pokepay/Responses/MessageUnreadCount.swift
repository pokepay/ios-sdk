import Foundation

public struct MessageUnreadCount: Codable {
    public let count: Int32

    private enum CodingKeys: String, CodingKey {
        case count
    }
}
