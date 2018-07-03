import Foundation

enum PokepayError: Error {
    case invalidJSON(Swift.Error)
    case unknown
    case apiError(APIError)

    init(object: Data) {
        do {
            let error = try JSONDecoder().decode(APIError.self, from: object)
            switch error.type {
            case "api_error": self = .apiError(error)
            default: self = .unknown
            }
        } catch let decodeError {
            self = .invalidJSON(decodeError)
            return
        }
    }
}
