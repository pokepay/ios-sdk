import APIKit
import Foundation

public extension BankAPI.Account {
    struct GetAccountCampaignPointAmounts: BankRequest {
        public let accountId: String
        public let campaignId: String
        public typealias Response = AccountCampaignPointAmounts

        public init(accountId: String, campaignId: String) {
            self.accountId = accountId
            self.campaignId = campaignId
        }

        public var method: HTTPMethod {
            return .get
        }

        public var path: String {
            return "/accounts/\(accountId)/campaigns/\(campaignId)/point-amounts"
        }
    }
}