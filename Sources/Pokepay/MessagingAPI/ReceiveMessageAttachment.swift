import APIKit

public extension MessagingAPI {
    struct ReceiveAttachment: BankRequest {
        public let id: String

        public typealias Response = MessageAttachment

        public init(id: String) {
            self.id = id
        }

        public var method: HTTPMethod {
            return .post
        }

        public var path: String {
            return "/messages/\(id)/attachment/receive"
        }
    }
}
