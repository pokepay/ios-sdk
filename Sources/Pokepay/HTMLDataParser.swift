import Foundation
import APIKit

final class DecodableDataParser: DataParser {
    var contentType: String? {
        return "text/html"
    }

    func parse(data: Data) throws -> Any {
        return data
    }
}
