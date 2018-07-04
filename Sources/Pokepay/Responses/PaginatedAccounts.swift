import Foundation

struct PaginatedAccounts: Codable {
    let perPage: Int32
    let count: Int32
    let next: String?
    let prev: String?
    let items: [Account]

    private enum CodingKeys: String, CodingKey {
        case perPage = "per_page"
        case count
        case next
        case prev
        case items
    }
}
