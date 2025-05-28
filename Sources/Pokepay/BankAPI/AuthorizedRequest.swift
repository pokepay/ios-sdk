import Foundation
import APIKit

struct AuthorizedRequest<R: APIKit.Request>: RequestProxy {
    typealias Request = R
    typealias Response = R.Response
    let request: R
    let accessToken: String
    var headerFields: [String: String] {
        var h = request.headerFields
        
        h["Authorization"] = "Bearer \(accessToken)"
        h["X-SDK-Version"] = SDKVersion
        
        return h
    }
    var endpoint: URL
    var baseURL: URL {
        return endpoint
    }

    public init(request: R, accessToken: String, endpoint: URL) {
        self.request = request
        self.accessToken = accessToken
        self.endpoint = endpoint
    }
}
