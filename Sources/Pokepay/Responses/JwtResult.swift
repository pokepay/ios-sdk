import Foundation

func base64urlToBase64(base64url: String) -> String {
    var base64 = base64url
        .replacingOccurrences(of: "-", with: "+")
        .replacingOccurrences(of: "_", with: "/")
    if base64.count % 4 != 0 {
        base64.append(String(repeating: "=", count: 4 - base64.count % 4))
    }
    return base64
}

public enum JwtResultError : Error {
    case invalidConvertionError(String)
}

public struct JwtResult: Codable {
    public let data: String?
    public let error: String?

    private enum CodingKeys: String, CodingKey {
        case data
        case error
    }

    private func getJWTBodyData(jwtToken: String) throws -> Data {
        let parts = jwtToken.components(separatedBy: ".")
        if parts.count > 1 {
            let payloadPart = parts[1]
            let payloadPartBase64 = base64urlToBase64(base64url: payloadPart)
            if let data = Data(base64Encoded: payloadPartBase64) {
                return data
            }
        }
        throw JwtResultError.invalidConvertionError("invalid jwt token")
    }

    public func parseAsUserTransaction() throws -> UserTransaction {
        if data != nil {
            let data = try getJWTBodyData(jwtToken: self.data!)
            let ut: UserTransaction = try JSONDecoder().decode(UserTransaction.self, from: data)
            return ut
        }
        throw JwtResultError.invalidConvertionError("data is not set")
    }

    public func parseAsAPIError() throws -> APIError {
        if error != nil {
            let error = try getJWTBodyData(jwtToken: self.error!)
            let ae: APIError = try JSONDecoder().decode(APIError.self, from: error)
            return ae
        }
        throw JwtResultError.invalidConvertionError("error is not set")
    }
}
