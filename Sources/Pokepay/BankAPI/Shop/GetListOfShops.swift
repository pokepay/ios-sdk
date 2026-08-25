import APIKit

public extension BankAPI.Shop {
    @available(*, deprecated, message: "Use Autogen.BankAPI.Shop.GetListOfShops instead. This hand-written request is being replaced by the auto-generated Autogen API.")
    struct GetListOfShops: BankRequest {
        public let privateMoneyId: String
        public let userTagGroupItemId: String?
        public let userTagSubgroupId: String?
        public let before: String?
        public let after: String?
        public let perPage: Int?

        public typealias Response = PaginatedShops

        public init(privateMoneyId: String, userTagGroupItemId: String? = nil, userTagSubgroupId: String? = nil, before: String? = nil, after: String? = nil, perPage: Int? = nil) {
            self.privateMoneyId = privateMoneyId
            self.userTagGroupItemId = userTagGroupItemId
            self.userTagSubgroupId = userTagSubgroupId
            self.before = before
            self.after = after
            self.perPage = perPage
        }

        public var method: HTTPMethod {
            return .get
        }

        public var path: String {
            return "/shops"
        }

        public var parameters: Any? {
            var dict: [String: Any] = [:]

            dict["private_money_id"] = privateMoneyId

            if userTagGroupItemId != nil {
                dict["user_tag_group_item_id"] = userTagGroupItemId
            }

            if userTagSubgroupId != nil {
                dict["user_tag_subgroup_id"] = userTagSubgroupId
            }

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
