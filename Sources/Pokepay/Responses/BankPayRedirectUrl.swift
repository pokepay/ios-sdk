import Foundation

public struct BankPayRedirectUrl: Codable {
    public let redirectUrl: String
    public let paytreeCustomerNumber: String?

    private enum CodingKeys: String, CodingKey {
        case redirectUrl
        case paytreeCustomerNumber
    }
}

