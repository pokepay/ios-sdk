import APIKit

public extension MessagingAPI {
    struct List: BankRequest {
        public let before: String?
        public let after: String?
        public let perPage: Int32?

        public typealias Response = PaginatedMessages

        public init(before: String? = nil, after: String? = nil, perPage: Int32? = nil) {
            self.before = before
            self.after = after
            self.perPage = perPage
        }

        public var method: HTTPMethod {
            return .get
        }

        public var path: String {
            return "/messages"
        }

        public var parameters: Any? {
            var dict: [String: Any] = [:]
            if before != nil {
                dict["before"] = before
            }
            if after != nil {
                dict["after"] = after
            }
            if perPage != nil {
                dict["per_page"] = perPage
            }
            return dict
        }
    }
}
