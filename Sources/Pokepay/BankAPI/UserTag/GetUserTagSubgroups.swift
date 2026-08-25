import APIKit

public extension BankAPI.UserTag {
    @available(*, deprecated, message: "Use Autogen.BankAPI.UserTag.GetUserTagSubgroups instead. This hand-written request is being replaced by the auto-generated Autogen API.")
    struct GetUserTagSubgroups: BankRequest {
        public let organizationCode: String
        public let tagGroupId: String
        public let before: String?
        public let after: String?
        public let perPage: Int?

        public typealias Response = PaginatedUserTagSubgroups

        public init(organizationCode: String, tagGroupId: String, before: String? = nil, after: String? = nil, perPage: Int? = nil) {
            self.organizationCode = organizationCode
            self.tagGroupId = tagGroupId
            self.before = before
            self.after = after
            self.perPage = perPage
        }

        public var method: HTTPMethod {
            return .get
        }

        public var path: String {
            return "/user-tag-groups/\(organizationCode)/subgroups"
        }

        public var parameters: Any? {
            var dict: [String: Any] = [:]

            dict["tag_group_id"] = tagGroupId

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
