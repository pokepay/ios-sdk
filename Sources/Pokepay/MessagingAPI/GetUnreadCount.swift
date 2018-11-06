import APIKit

public extension MessagingAPI {
    public struct GetUnreadCount: BankRequest {
        public typealias Response = MessageUnreadCount

        public var method: HTTPMethod {
            return .get
        }

        public var path: String {
            return "/messages/unread-count"
        }
    }
}
