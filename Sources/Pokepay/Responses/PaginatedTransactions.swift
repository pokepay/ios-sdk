import Foundation

struct PaginatedTransactions: Codable {
    let perPage: Int32
    let count: Int32
    let next: String?
    let prev: String?
    let items: [UserTransaction]

    private enum CodingKeys: String, CodingKey {
        case perPage = "per_page"
        case count
        case next
        case prev
        case items
    }
}
