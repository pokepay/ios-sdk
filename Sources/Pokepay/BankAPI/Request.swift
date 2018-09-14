import Foundation
import APIKit

let API_BASE_URL = "https://api-dev.pokepay.jp"
let WWW_BASE_URL = "https://www-dev.pokepay.jp"

public protocol BankRequest: Request {
}

public extension BankRequest {
    public var baseURL: URL {
        return URL(string: API_BASE_URL)!
    }
}

public extension BankRequest {
    public func intercept(object: Any, urlResponse: HTTPURLResponse) throws -> Any {
        guard (200..<300).contains(urlResponse.statusCode) else {
            throw BankAPIError(object: object as! Data)
        }
        return object
    }
}

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

extension BankRequest where Response: Decodable {
    public var dataParser: DataParser {
        return DecodableDataParser()
    }

    public func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response {
        guard let data = object as? Data else {
            throw BankAPIError(object: Data())
        }
        guard data.count != 0 else {
            let emptyJson = "{}"
            return try JSONDecoder().decode(Response.self, from: emptyJson.data(using: .utf8)!)
        }
        return try JSONDecoder().decode(Response.self, from: data)
    }
}
