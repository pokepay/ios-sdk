import APIKit

public extension MessagingAPI {
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
