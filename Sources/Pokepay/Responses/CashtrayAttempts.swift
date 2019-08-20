import Foundation

public struct CashtrayAttempts: Codable {
    public let rows: [CashtrayAttempt]

    private enum CodingKeys: String, CodingKey {
        case rows
    }
}
