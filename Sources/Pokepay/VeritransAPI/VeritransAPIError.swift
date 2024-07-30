import Foundation

public enum VeritransAPIError: Error {
    case invalidJSON(Swift.Error)
    case unknownError(Int?, VeritransError)
    case clientError(Int, VeritransError)
    case serverError(Int, VeritransError)

    init(statusCode: Int? = nil, object: Data) {
        do {
            let error = try JSONDecoder().decode(VeritransError.self, from: object)
            guard let code = statusCode else {
                self = .unknownError(statusCode, error)
                return
            }
            if ((400..<500).contains(code)) {
                 self = .clientError(code, error)
            }else if ((500..<600).contains(code)) {
                  self = .serverError(code, error)
            }else {
                  self = .unknownError(code, error)
            }
        } catch let decodeError {
             self = .invalidJSON(decodeError)
             return
        }
    }
}
