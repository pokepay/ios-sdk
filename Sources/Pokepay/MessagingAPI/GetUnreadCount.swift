import APIKit

public extension MessagingAPI {
    /**
     Retrieves a number of unread messages from Messaging API.
     
     The API endpoint is `GET /messages/unread-count`.
    */
    public struct GetUnreadCount: BankRequest {
        public typealias Response = MessageUnreadCount

        public init() {
        }

        public var method: HTTPMethod {
            return .get
        }

        public var path: String {
            return "/messages/unread-count"
        }
    }
}
