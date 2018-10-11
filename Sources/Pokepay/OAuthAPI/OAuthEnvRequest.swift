import Foundation
import APIKit

struct OAuthEnvRequest<R: APIKit.Request>: RequestProxy {
    typealias Request = R
    typealias Response = R.Response
    let request: R
    var endpoint: URL
    var baseURL: URL {
        return endpoint
    }

    public init(request: R, endpoint: URL) {
        self.request = request
        self.endpoint = endpoint
    }
}
