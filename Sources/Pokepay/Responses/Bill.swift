import Foundation

public struct Bill: Codable {
    public let id: String
    public let amount: Double?
    public let description: String
    public let user: User
}
