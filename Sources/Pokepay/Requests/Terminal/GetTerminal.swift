import APIKit

struct GetTerminalRequest: PokepayRequest {
    typealias Response = Terminal

    init() {}

    var method: HTTPMethod {
        return .get
    }

    var path: String {
        return "/terminal"
    }
}
