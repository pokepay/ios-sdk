import APIKit

public extension BankAPI.Transaction {
    public struct CreateWillCashtray: BankRequest {
        public let cashtrayId: String
        public let accountId: String?

        public typealias Response = UserTransaction

        public init(cashtrayId: String, accountId: String?) {
            self.cashtrayId = cashtrayId
            self.accountId = accountId
        }

        public var method: HTTPMethod {
            return .post
        }

        public var path: String {
            return "/transactions"
        }

        public var parameters: Any? {
            var dict = ["cashtray_id": cashtrayId]
            if accountId != nil {
                dict["account_id"] = accountId
            }
            return dict
        }
    }
}
