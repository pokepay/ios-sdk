// DO NOT EDIT: File is generated by code generator.
import Foundation

public struct CreditCard: Codable {
    public let cardNumber: String;
    public let registeredAt: String;

    private enum CodingKeys: String, CodingKeys {
        case cardNumber = "card_number"
        case registeredAt = "registered_at"
    }
}
