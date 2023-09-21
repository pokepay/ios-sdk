import Foundation

public struct BankPay: Codable {
    public let id: String
    public let bankName: String
    public let bankCode: String
    public let branchNumber: String
    public let branchName: String
    public let depositType: Int32
    public let maskedAccountNumber: String
    public let accountName: String
    public let privateMoneyId: String?

    private enum CodingKeys: String, CodingKey {
        case id
        case bankName = "bank_name"
        case bankCode = "bank_code"
        case branchNumber = "branch_number"
        case branchName = "branch_name"
        case depositType = "deposit_type"
        case maskedAccountNumber = "masked_account_number"
        case accountName = "account_name"
        case privateMoneyId = "private_money_id"
    }
}
