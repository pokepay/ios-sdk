import Foundation
import APIKit

// Prevents APIError from decoding Data to JSON object implicitly
// This would be unnecessary in APIKit 4.0
final class DecodableDataParser: DataParser {
    var contentType: String? {
        return "application/json"
    }

    func parse(data: Data) throws -> Any {
        return data
    }
}
