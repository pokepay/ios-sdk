import APIKit

public extension BankAPI.Account {
    struct GetAccountSevenElevenAtmSession: BankRequest {
        public let qrInfo: String
        
        public typealias Response = SevenElevenAtmSession
        
        public init(qrInfo: String) {
            self.qrInfo = qrInfo
        }
        
        public var method: HTTPMethod {
            return .get
        }
        
        public var path: String {
            return "/seven-bank-atm-sessions/\(qrInfo)"
        }
    }
}

