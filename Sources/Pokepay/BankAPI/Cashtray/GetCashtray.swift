import APIKit

extension BankAPI.Cashtray {
    struct Get: BankRequest {
        let id: String

        typealias Response = Cashtray

        init(id: String) {
            self.id = id
        }

        var method: HTTPMethod {
            return .get
        }

        var path: String {
            return "/cashtrays/\(id)"
        }
    }
}
