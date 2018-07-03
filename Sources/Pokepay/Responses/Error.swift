import Foundation

struct APIError: Codable {
    let type: String
    let message: String
}
