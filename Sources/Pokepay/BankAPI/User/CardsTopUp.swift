import APIKit

public extension BankAPI.User {
    @available(*, deprecated, message: "Use Autogen.BankAPI.CreditCard.TopupWithCreditCard instead. This hand-written request is being replaced by the auto-generated Autogen API.")
    struct CardsTopUp: BankRequest {
        public let id: String
        public let accountId: String
        public let cardRegisteredAt: String
        public let amount: String
        public typealias Response = UserTransaction
        
        public init(id: String, accountId: String ,cardRegisteredAt: String, amount: String) {
            self.id = id
            self.accountId = accountId
            self.cardRegisteredAt = cardRegisteredAt
            self.amount = amount
        }
        
        public var method: HTTPMethod {
            return .post
        }
        
        public var path: String {
            return "/users/\(id)/cards/topup"
        }
        
        public var parameters: Any? {
            let dict: [String: Any] = [
                "account_id": accountId,
                "card_registered_at": cardRegisteredAt,
                "amount": amount
            ]
            return dict
        }
        
    }
}
