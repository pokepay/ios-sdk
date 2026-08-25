
import APIKit

public extension BankAPI.User {
    @available(*, deprecated, message: "Use Autogen.BankAPI.User.GetUserSettingUrl instead. This hand-written request is being replaced by the auto-generated Autogen API.")
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
