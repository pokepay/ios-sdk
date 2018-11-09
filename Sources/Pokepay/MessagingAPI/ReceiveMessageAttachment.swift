import APIKit

public extension MessagingAPI {
    /**
     Receives an attachment of a message.
     
     The endpoint is `POST /messages/{id}/attachment/receive`.
     If the message doesn't have an attachment, it returns 404 Not Found.
     If the attachment is already received, it still returns 200 OK though the process runs only when the first time.
     */
    public struct ReceiveAttachment: BankRequest {
        public let message: Message

        public typealias Response = MessageAttachment

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
