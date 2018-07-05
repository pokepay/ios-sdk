import APIKit

public extension BankAPI.Cashtray {
    public struct Get: BankRequest {
        public let id: String

        public typealias Response = Cashtray

        public init(id: String) {
            self.id = id
        }

        public var method: HTTPMethod {
            return .get
        }

        public var path: String {
            return "/cashtrays/\(id)"
        }
    }
}
