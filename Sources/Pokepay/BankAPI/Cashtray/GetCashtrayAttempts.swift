import APIKit

public extension BankAPI.Cashtray {
    @available(*, deprecated, message: "Use Autogen.BankAPI.Cashtray.GetCashtrayAttempts instead. This hand-written request is being replaced by the auto-generated Autogen API.")
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
