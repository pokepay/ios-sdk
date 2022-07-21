import APIKit

public extension BankAPI.Account {

    struct CreateAccountSevenElevenAtmSessions: BankRequest {
        public let accountId: String
        public let qrInfo: String

        public typealias Response = SevenElevenAtmSession

        public init(accountId: String, qrInfo: String) {
            self.accountId = accountId
            self.qrInfo = qrInfo
        }

        public var method: HTTPMethod {
            return .post
        }

        public var path: String {
            return "/accounts/\(accountId)/seven-bank-atm-sessions"
        }

        public var parameters: Any? {
            return ["qr_info": qrInfo]
        }

    }

}