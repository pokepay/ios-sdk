import Foundation

public struct CvsAuthorization: Codable {
    public let id: String
    public let serviceOptionType: String
    public let amount: Int
    public let name1: String
    public let name2: String
    public let tel: String
    public let payLimit: String
    public let account: Account
    public let haraikomiUrl: String
    public let receiptNo: String
    public let doneAt: String?
    public let canceledAt: String?

    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case serviceOptionType = "service_option_type"
        case amount = "amount"
        case name1 = "name1"
        case name2 = "name2"
        case tel = "tel"
        case payLimit = "pay_limit"
        case account = "account"
        case haraikomiUrl = "haraikomi_url"
        case receiptNo = "receipt_no"
        case doneAt = "done_at"
        case canceledAt = "canceled_at"
    }
}
