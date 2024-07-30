import Foundation

public struct VeritransToken: Codable {
    public let token: String

    private enum CodingKeys: String, CodingKey {
        case token = "token"
    }
}
