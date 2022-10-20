import Foundation
import APIKit

public extension MessagingAPI {
    struct Send: BankRequest {
        public let toUserId: String
        public let amount: Double?
        public let subject: String
        public let body: String
        public let sender: User
        public let fromAccountId: String?
        public var requestId: String {
            return UUID().uuidString
        }

        public typealias Response = Message

        public init(toUserId: String, amount: Double? = nil, subject: String = "", body: String = "", sender: User, fromAccountId: String? = nil) {
            self.toUserId = toUserId
            self.amount = amount
            self.subject = subject
            self.body = body
            self.sender = sender
            self.fromAccountId = fromAccountId
        }

        public var method: HTTPMethod {
            return .post
        }

        public var path: String {
            return "/messages"
        }

        public var parameters: Any? {
            var dict: [String: Any] = [:]
            dict["to_user_id"] = toUserId
            if amount != nil && sender.isMerchant{
                dict["amount"] = amount
            }
            dict["subject"] = subject
            dict["body"] = body
            if fromAccountId != nil {
                dict["from_account_id"] = fromAccountId
            }
            dict["_request_id"] = requestId
            return dict
        }
    }
}
