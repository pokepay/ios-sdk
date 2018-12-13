import Foundation

public struct JwtResult: Codable {
    public let data: String?
    public let error: String?

    private enum CodingKeys: String, CodingKey {
        case data
        case error
    }
}
