// DO NOT EDIT: File is generated by code generator.
import APIKit

public extension BankAPI.CreditCard {
    struct DeleteCreditCard: BankRequest {
        public let cardRegisteredAt: String
        public let organizationCode: String?
        public let userId: String

        public typealias Response = NoContent

        public init(cardRegisteredAt: String, organizationCode: String? = nil, userId: String) {
            self.cardRegisteredAt = cardRegisteredAt
            self.organizationCode = organizationCode
            self.userId = userId
        }

        public var method: HTTPMethod {
            return .post
        }

        public var path: String {
            return "/users/\(userId)/cards/delete"
        }

        public var parameters: Any? {
            var dict: [String: Any] = [:]

            dict["card_registered_at"] = cardRegisteredAt

            if organizationCode != nil {
                dict["organization_code"] = organizationCode
            }

            return dict
        }
    }
}
