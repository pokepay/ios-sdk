import APIKit

public extension BankAPI.Check {
    @available(*, deprecated, message: "Use Autogen.BankAPI.Check.GetCheck instead. This hand-written request is being replaced by the auto-generated Autogen API.")
    struct Get: BankRequest {
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
