import Foundation
import APIKit

let DEFAULT_API_BASE_URL = "https://api-sandbox.pokepay.jp"

public protocol BankRequest: Request {
}

public extension BankRequest {
    public var baseURL: URL {
        return URL(string: DEFAULT_API_BASE_URL)!
    }
}

public extension BankRequest {
    public func intercept(object: Any, urlResponse: HTTPURLResponse) throws -> Any {
        guard (200..<300).contains(urlResponse.statusCode) else {
            throw BankAPIError(statusCode: urlResponse.statusCode, object: object as! Data)
        }
        return object
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
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS'Z'"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        guard data.count != 0 else {
            let emptyJson = "{}"
            return try decoder.decode(Response.self, from: emptyJson.data(using: .utf8)!)
        }
        return try decoder.decode(Response.self, from: data)
    }
}
