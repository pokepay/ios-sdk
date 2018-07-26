import Foundation
import APIKit

protocol RequestProxy: APIKit.Request {
    associatedtype Request: APIKit.Request
    var request: Request { get }
}

extension RequestProxy {
    var baseURL: URL {
        return request.baseURL
    }

    var headerFields: [String: String] {
        return request.headerFields
    }

    var method: HTTPMethod {
        return request.method
    }

    var path: String {
        return request.path
    }

    var dataParser: DataParser {
        return request.dataParser
    }

    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Request.Response {
        return try request.response(from: object, urlResponse: urlResponse)
    }
    func intercept(object: Any, urlResponse: HTTPURLResponse) throws -> Any {
        return try request.intercept(object: object, urlResponse: urlResponse)
    }
}

struct AuthorizedRequest<R: APIKit.Request>: RequestProxy {
    typealias Request = R
    typealias Response = R.Response
    let request: R
    let accessToken: String
    var headerFields: [String: String] {
        var h = request.headerFields
        h["Authorization"] = "Bearer \(accessToken)"
        return h
    }
}
