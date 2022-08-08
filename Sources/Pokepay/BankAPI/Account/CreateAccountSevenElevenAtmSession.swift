import APIKit

public extension BankAPI.Account {

    struct CreateAccountSevenElevenAtmSessions: BankRequest {
        public let accountId: String
        public let qrInfo: String
        public let amount: Double

        public typealias Response = SevenElevenAtmSession

        public init(accountId: String, qrInfo: String, amount: Double) {
            self.accountId = accountId
            self.qrInfo = qrInfo
            self.amount = amount
        }

        public var method: HTTPMethod {
            return .post
        }

        public var path: String {
            return "/accounts/\(accountId)/seven-bank-atm-sessions"
        }

        public var parameters: Any? {
             var dict: [String: Any] = [:]
             dict["qr_info"] = qrInfo
             dict["amount"] = amount
            
            return dict
        }

    }

}