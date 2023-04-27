import Foundation

public struct UserWithAuthFactors: Codable {
    public let id: String
    public let name: String
    public let isMerchant: Bool
    public let tel: String?
    public let email: String?
    public let isPasswordRegistered: Bool

    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case isMerchant = "is_merchant"
        case tel
        case email
        case isPasswordRegistered = "is_password_registered"
    }
}
