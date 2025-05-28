import Foundation
import APIKit

let DEFAULT_WWW_BASE_URL = "https://www-sandbox.pokepay.jp"

public protocol OAuthAPIRequest: Request {
}

public extension OAuthAPIRequest {
    var baseURL: URL {
        return URL(string: DEFAULT_WWW_BASE_URL)!
    }
}

public extension OAuthAPIRequest {
    func intercept(object: Any, urlResponse: HTTPURLResponse) throws -> Any {
        guard (200..<300).contains(urlResponse.statusCode) else {
            throw OAuthAPIError(statusCode: urlResponse.statusCode, object: object as! Data)
        }
        return object
    }
}

extension OAuthAPIRequest where Response: Decodable {
    public var dataParser: DataParser {
        return DecodableDataParser()
    }

    public func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response {
        guard let data = object as? Data else {
            throw OAuthAPIError(statusCode: urlResponse.statusCode, object: Data())
        }
        guard data.count != 0 else {
            let emptyJson = "{}"
            return try JSONDecoder().decode(Response.self, from: emptyJson.data(using: .utf8)!)
        }
        return try JSONDecoder().decode(Response.self, from: data)
    }
}
