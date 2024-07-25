import Foundation
import APIKit

let DEFAULT_API_BASE_URL = "https://api-sandbox.pokepay.jp"

public protocol BankRequest: Request {
    var responseContentType: String { get }
}

public extension BankRequest {
    var baseURL: URL {
        return URL(string: DEFAULT_API_BASE_URL)!
    }

    var responseContentType: String {
        return "application/json"
    }
}

public extension BankRequest {
    func intercept(object: Any, urlResponse: HTTPURLResponse) throws -> Any {
        guard (200..<300).contains(urlResponse.statusCode) else {
            throw BankAPIError(statusCode: urlResponse.statusCode, object: object as! Data)
        }
        return object
    }
}

extension BankRequest where Response: Decodable {
    public var dataParser: DataParser {
        switch responseContentType {
        case "text/html":
            return HTMLDataParser()
        default:
            return DecodableDataParser()
        }
    }

    public func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response {
        guard let data = object as? Data else {
            throw BankAPIError(statusCode: urlResponse.statusCode, object: Data())
        }

        guard data.count != 0 else {
            let emptyJson = "{}"
            return try BankAPIJSONDecoder().decode(Response.self, from: emptyJson.data(using: .utf8)!)
        }

        switch responseContentType {
        case "text/html":
            if let htmlString = String(data: data, encoding: .utf8) as? Response {
                return htmlString
            } else {
                throw BankAPIError(statusCode: urlResponse.statusCode, object: data)
            }
        default:
            return try BankAPIJSONDecoder().decode(Response.self, from: data)
        }
    }
}
