import APIKit

public extension BankAPI.Bill {
    struct Get: BankRequest {
        public let id: String

        public typealias Response = BillWithAdditionalPrivateMoneys

        public init(id: String) {
            self.id = id
        }

        public var method: HTTPMethod {
            return .get
        }

        public var path: String {
            return "/bills/\(id)"
        }
    }
}
