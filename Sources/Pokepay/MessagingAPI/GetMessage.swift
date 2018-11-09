import APIKit

public extension MessagingAPI {
    /**
     Gets the information of a single message and marks it as read.
     
     The endpoint is `GET /messages/{id}`.
     */
    public struct Get: BankRequest {
        public let id: String

        public typealias Response = Message

        public init(id: String) {
            self.id = id
        }

        public var method: HTTPMethod {
            return .get
        }

        public var path: String {
            return "/messages/\(id)"
        }
    }
}
