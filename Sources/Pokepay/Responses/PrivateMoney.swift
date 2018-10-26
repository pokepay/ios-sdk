import Foundation

public struct PrivateMoney: Codable {
    public let id: String
    public let name: String
    public let type: String
    public let description: String
    public let onelineMessage: String
    public let images: Dictionary<String, String>
    public let organization: Organization
    public let maxBalance: Double
    public let transferLimit: Double
    public let expirationType: String
    public let isExclusive: Bool
    public let termsUrl: String?
    public let privacyPolicyUrl: String?
    public let paymentActUrl: String?
    public let commercialActUrl: String?

    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case type
        case description
        case onelineMessage = "oneline_message"
        case images
        case organization
        case maxBalance = "max_balance"
        case transferLimit = "transfer_limit"
        case expirationType = "expiration_type"
        case isExclusive = "is_exclusive"
        case termsUrl = "terms_url"
        case privacyPolicyUrl = "privacy_policy_url"
        case paymentActUrl = "payment_act_url"
        case commercialActUrl = "commercial_act_url"
    }
}
