import Foundation

public struct TopupMethod: Codable {
    // "type" can be "credit-card", "sevenbank-atm", "paytree-bank", or "cvs"
    public let type: String
    public let name: String
    public let amounts: [Double]?
    public let range: [Double]?
}
