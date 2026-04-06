import APIKit
import Foundation

public extension BankAPI.Transaction {
    struct CreateWithCheck: BankRequest {
        public let checkId: String
        public let accountId: String?
        public let requestId: UUID?
        public let topupQuotaId: Int?

        public typealias Response = UserTransaction

        public init(checkId: String, accountId: String? = nil, requestId: UUID? = nil, topupQuotaId: Int? = nil) {
            self.requestId = requestId
            self.checkId = checkId
            self.accountId = accountId
            self.topupQuotaId = topupQuotaId
        }

        public var method: HTTPMethod {
            return .post
        }

        public var path: String {
            return "/transactions"
        }

        public var parameters: Any? {
            var dict: [String: Any] = [:]
            dict["check_id"] = checkId
            if accountId != nil {
                dict["account_id"] = accountId
            }
            if requestId != nil {
                dict["request_id"] = requestId?.uuidString
            }
            if topupQuotaId != nil {
                dict["topup_quota_id"] = topupQuotaId
            }
            return dict
        }
    }
}
