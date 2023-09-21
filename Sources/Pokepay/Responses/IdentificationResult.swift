import Foundation

public struct IdentificationResult: Codable {
    public let isValid: Bool
    public let identifiedAt: String?
    public let match: IdentificationMatch

    private enum CodingKeys: String, CodingKey {
        case isValid = "is_valid"
        case identifiedAt = "identified_at"
        case match
    }
}