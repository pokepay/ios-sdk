import APIKit

public extension BankAPI.CreditCard {
    @available(*, deprecated, message: "Use Autogen.BankAPI.CreditCard.DeleteCreditCard instead. This hand-written request is being replaced by the auto-generated Autogen API.")
    struct DeleteCreditCard: BankRequest {
        public let cardRegisteredAt: String?
        public let cardUuid: String?
        public let organizationCode: String
        public let userId: String

        public typealias Response = NoContent

        public init(cardRegisteredAt: String? = nil, cardUuid: String? = nil, organizationCode: String, userId: String) {
            self.cardRegisteredAt = cardRegisteredAt
            self.cardUuid = cardUuid
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

            if cardRegisteredAt != nil {
                dict["card_registered_at"] = cardRegisteredAt
            }

            if cardUuid != nil {
                dict["card_uuid"] = cardUuid
            }

            dict["organization_code"] = organizationCode

            return dict
        }
    }
}
