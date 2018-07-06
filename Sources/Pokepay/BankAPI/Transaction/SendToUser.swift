import APIKit

public extension BankAPI.Transaction {
    public struct SendToUser: BankRequest {
        public let userId: String
        public let amount: Double
        public let receiverTerminalId: String?
        public let senderAccountId: String?
        public let description: String?

        public typealias Response = UserTransaction

        public init(to userId: String, amount: Double, receiverTerminalId: String? = nil, senderAccountId: String? = nil, description: String? = nil) {
            self.userId = userId
            self.amount = amount
            self.receiverTerminalId = receiverTerminalId
            self.senderAccountId = senderAccountId
            self.description = description
        }

        public var method: HTTPMethod {
            return .post
        }

        public var path: String {
            return "/users/\(userId)/transactions"
        }

        public var parameters: Any? {
            var dict: [String: Any] = ["amount": amount]
            if receiverTerminalId != nil {
                dict["receiver_terminal_id"] = receiverTerminalId
            }
            if senderAccountId != nil {
                dict["sender_account_id"] = senderAccountId
            }
            if description != nil {
                dict["description"] = description
            }
            return dict
        }
    }
}
