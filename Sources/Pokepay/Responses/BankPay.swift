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
        case bankName
        case bankCode
        case branchNumber
        case branchName
        case depositType
        case maskedAccountNumber
        case accountName
        case privateMoneyId
    }
}
