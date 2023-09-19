import Foundation

public struct IdentificationMatch: Codable {
    public let name: Bool
    public let gender: Bool
    public let address: Bool
    public let dateOfBirth: Bool

    private enum CodingKeys: String, CodingKey {
        case name
        case gender
        case address
        case dateOfBirth = "date_of_birth"
    }
}