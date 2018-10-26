import Foundation

public struct PaginatedAccountBalances: Codable {
    public let perPage: Int32
    public let count: Int32
    public let next: String?
    public let prev: String?
    public let items: [AccountBalance]

    private enum CodingKeys: String, CodingKey {
        case perPage = "per_page"
        case count
        case next
        case prev
        case items
    }
}
