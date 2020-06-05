import APIKit

public extension BankAPI.Check {
    struct Update: BankRequest {
        public let id: String
        public let amount: Double?
        public let description: String?
        public let expiresAt: Date?
        public let pointExpiresAt: Date?
        public let pointExpiresInDays: Int32?

        public typealias Response = Check

        public init(id: String, amount: Double? = nil, description: String? = nil, expiresAt: Date? = nil, pointExpiresAt: Date? = nil, pointExpiresInDays: Int32? = nil) {
            self.id = id
            self.amount = amount
            self.description = description
            self.expiresAt = expiresAt
            self.pointExpiresAt = pointExpiresAt
            self.pointExpiresInDays = pointExpiresInDays
        }

        public var method: HTTPMethod {
            return .patch
        }

        public var path: String {
            return "/checks/\(id)"
        }

        public var parameters: Any? {
            var dict: [String: Any] = [:]
            if amount != nil {
                dict["amount"] = amount
            }
            if description != nil {
                dict["description"] = description
            }
            if expiresAt != nil {
                dict["expires_at"] = BankAPIJSONDecoder.dateFormatter.string(from: expiresAt!)
            }
            if pointExpiresAt != nil {
                dict["point_expires_at"] =  BankAPIJSONDecoder.dateFormatter.string(from: pointExpiresAt!)
            }
            if pointExpiresInDays != nil {
                dict["point_expires_in_days"] = pointExpiresInDays
            }
            return dict
        }
    }
}
