import APIKit

public extension BankAPI.Bill {
    @available(*, deprecated, message: "Use Autogen.BankAPI.Bill.DeleteBill instead. This hand-written request is being replaced by the auto-generated Autogen API.")
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
            return "/bills/\(id)"
        }
    }
}
