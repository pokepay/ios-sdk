import Foundation
import APIKit

public protocol VeritransAPIRequest: Request {
}

public extension VeritransAPIRequest {
    var baseURL: URL {
        return URL(string: "https://api3.veritrans.co.jp")!
    }
}

public extension VeritransAPIRequest {
    func intercept(object: Any, urlResponse: HTTPURLResponse) throws -> Any {
        guard (200..<300).contains(urlResponse.statusCode) else {
            throw VeritransAPIError(statusCode: urlResponse.statusCode, object: object as! Data)
        }
        return object
    }
}

extension VeritransAPIRequest where Response: Decodable {
    public var dataParser: DataParser {
        return DecodableDataParser()
    }

    public func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response {
        guard let data = object as? Data else {
            throw VeritransAPIError(statusCode: urlResponse.statusCode, object: Data())
        }
        guard data.count != 0 else {
            let emptyJson = "{}"
            return try JSONDecoder().decode(Response.self, from: emptyJson.data(using: .utf8)!)
        }
        return try JSONDecoder().decode(Response.self, from: data)
    }
}
