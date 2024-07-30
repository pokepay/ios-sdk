import APIKit

public extension VeritransAPI.Token {
    struct GetVeritransToken: VeritransAPIRequest {
        public let cardNumber: String
        public let cardExpiryDate: String
        public let securityCode: String
        public let tokenApiKey: String

        public typealias Response = VeritransToken

        public init(cardNumber: String, cardExpiryDate: String, securityCode: String, tokenApiKey: String) {
            self.cardNumber = cardNumber
            self.cardExpiryDate = cardExpiryDate
            self.securityCode = securityCode
            self.tokenApiKey = tokenApiKey
        }

        public var method: HTTPMethod {
            return .post
        }

        public var path: String {
            return "/4gtoken"
        }

        public var parameters: Any? {
            return [
              "card_number": cardNumber,
              "card_expire": cardExpiryDate,
              "security_code": securityCode,
              "token_api_key": tokenApiKey
            ]
        }
    }
}
