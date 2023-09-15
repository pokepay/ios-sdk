import Foundation

public struct BankPayRedirectUrl: Codable {
    public let redirectUrl: String

    private enum CodingKeys: String, CodingKey {
        case redirectUrl = "redirect_url"
    }
}

