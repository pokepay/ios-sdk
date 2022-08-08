public struct SevenElevenAtmSession: Codable {
    public let qrInfo: String
    public let amount: Double
    public let account: Account

    private enum CodingKeys: String, CodingKey {
        case qrInfo = "qr_info"
        case amount
        case account
    }
}