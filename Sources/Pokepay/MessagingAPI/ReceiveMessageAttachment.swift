import APIKit

public extension MessagingAPI {
    public struct ReceiveAttachment: BankRequest {
        public let message: Message

        public typealias Response = Message

        public init(message: Message) {
            self.message = message
        }

        public var method: HTTPMethod {
            return .post
        }

        public var path: String {
            return "/messages/\(message.id)/attachment/receive"
        }
    }
}
