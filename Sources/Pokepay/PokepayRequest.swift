import Foundation
import APIKit
import KeychainAccess

let API_BASE_URL = "https://api-dev.***REMOVED***"

protocol PokepayRequest: Request {
}

extension PokepayRequest {
    var baseURL: URL {
        return URL(string: API_BASE_URL)!
    }
    var headerFields: [String: String] {
        let keychain = Keychain(service: "jp.pocket-change.pay")
        guard let accessToken = keychain["accessToken"] else {
            return [:]
        }
        return [
          "Authorization": "Bearer \(accessToken)"
        ]
    }
}

extension PokepayRequest {
    func intercept(object: Any, urlResponse: HTTPURLResponse) throws -> Any {
        guard (200..<300).contains(urlResponse.statusCode) else {
            throw PokepayError(object: object as! Data)
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

extension PokepayRequest where Response: Decodable {
    var dataParser: DataParser {
        return DecodableDataParser()
    }

    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response {
        guard let data = object as? Data else {
            throw PokepayError(object: Data())
        }
        return try JSONDecoder().decode(Response.self, from: data)
    }
}
