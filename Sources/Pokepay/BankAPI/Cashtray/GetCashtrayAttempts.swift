import APIKit

public extension BankAPI.Cashtray {
    struct GetAttempts: BankRequest {
        public let id: String

        public typealias Response = CashtrayAttempts

        public init(id: String) {
            self.id = id
        }

        public var method: HTTPMethod {
            return .get
        }

        public var path: String {
            return "/cashtrays/\(id)/attempts"
        }
    }
}
