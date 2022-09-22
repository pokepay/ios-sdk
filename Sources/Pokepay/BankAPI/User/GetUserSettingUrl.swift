
import APIKit

public extension BankAPI.User {
    struct GetUserSettingUrl: BankRequest {
        public let accessCode: String

        public typealias Response = UserSettingUrl

        public init(accessCode: String) {
            self.accessCode = accessCode
        }

        public var method: HTTPMethod {
            return .post
        }

        public var path: String {
            return "/oauth/full-access"
        }
    }
}
