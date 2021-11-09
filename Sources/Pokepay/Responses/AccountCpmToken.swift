import Foundation

public struct AccountCpmToken: Codable {
    public let cpmToken: String
    public let account: Account
    public let transaction: UserTransaction?
    public let scopes: [String]
    public let expiresAt: Date
    public let metadata: [String:String]?

    private enum CodingKeys: String, CodingKey {
        case cpmToken = "cpm_token"
        case account
        case transaction
        case scopes
        case expiresAt = "expires_at"
        case metadata
    }
}
