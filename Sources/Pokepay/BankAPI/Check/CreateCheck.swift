import APIKit

public extension BankAPI.Check {
    struct Create: BankRequest {
        public let amount: Double?
        public let moneyAmount: Double?
        public let pointAmount: Double?
        public let accountId: String?
        public let description: String?
        public let isOnetime: Bool;
        public let usageLimit: Int32?;
        public let expiresAt: Date?;
        public let pointExpiresAt: Date?;
        public let pointExpiresInDays: Int32?;

        public typealias Response = Check

        public init(amount: Double? = nil,
                    moneyAmount: Double? = nil,
                    pointAmount: Double? = nil,
                    accountId: String? = nil,
                    description: String? = nil,
                    isOnetime: Bool,
                    usageLimit: Int32? = nil,
                    expiresAt: Date? = nil,
                    pointExpiresAt: Date? = nil,
                    pointExpiresInDays: Int32? = nil ) {
            self.amount = amount
            self.moneyAmount = moneyAmount
            self.pointAmount = pointAmount
            self.accountId = accountId
            self.description = description
            self.isOnetime = isOnetime
            self.usageLimit = usageLimit
            self.expiresAt = expiresAt
            self.pointExpiresAt = pointExpiresAt
            self.pointExpiresInDays = pointExpiresInDays
        }

        public var method: HTTPMethod {
            return .post
        }

        public var path: String {
            return "/checks"
        }

        public var parameters: Any? {
            var dict: [String: Any] = [:]
            if amount != nil {
                dict["amount"] = amount
            }
            if accountId != nil {
                dict["account_id"] = accountId
            }
            if description != nil {
                dict["description"] = description
            }
            if moneyAmount != nil {
                dict["money_amount"] = moneyAmount
            }
            if pointAmount != nil {
                dict["point_amount"] = pointAmount
            }
            dict["is_onetime"] = isOnetime
            if usageLimit != nil {
                dict["usage_limit"] = usageLimit
            }
            if expiresAt != nil {
                dict["expires_at"] = BankAPIJSONDecoder.dateFormatter.string(from: expiresAt!)
            }
            if pointExpiresAt != nil {
                dict["point_expires_at"] = BankAPIJSONDecoder.dateFormatter.string(from: pointExpiresAt!)
            }
            if pointExpiresInDays != nil {
                dict["point_expires_in_days"] = pointExpiresInDays
            }
            return dict
        }
    }
}
