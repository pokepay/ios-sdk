import Foundation

public struct APIError: Codable {
    public let type: String
    public let message: String
    public let errors: DynamicErrors?
}

public enum DynamicErrors: Codable {
    case empty
    case string(String)
    case invalid([String])
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        if let stringResult = try? container.decode(String.self) {
            self = .string(stringResult)
        } else if let invalidErrs = try? container.decode(InvalidParametersError.self) {
            self = .invalid(invalidErrs.invalid)
        } else {
            self = .empty
        }
    }
    
}

public struct InvalidParametersError: Codable {
    public let invalid: [String]
}

public struct OAuthError: Codable {
    public let error: String
}
