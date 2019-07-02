import APIKit

public extension BankAPI.Check {
    struct Delete: BankRequest {
        public let id: String

        public typealias Response = NoContent

        public init(id: String) {
            self.id = id
        }

        public var method: HTTPMethod {
            return .delete
        }

        public var path: String {
            return "/checks/\(id)"
        }
    }
}
