import APIKit

public extension BankAPI.Check {
    public struct Get: BankRequest {
        public let id: String

        public typealias Response = Check

        public init(id: String) {
            self.id = id
        }

        public var method: HTTPMethod {
            return .get
        }

        public var path: String {
            return "/checks/\(id)"
        }
    }
}
