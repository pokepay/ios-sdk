import Foundation

public struct CashtrayAttempt: Codable {
    public let user: User
    public let account: Account?
    public let statusCode: Int
    public let errorType: String?
    public let errorMessage: String?
    public let createdAt: Date

    private enum CodingKeys: String, CodingKey {
        case user
        case account
        case statusCode = "status_code"
        case errorType = "error_type"
        case errorMessage = "error_message"
        case createdAt = "created_at"
    }
}
