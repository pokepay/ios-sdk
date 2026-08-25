import APIKit

public extension BankAPI.Account {
    @available(*, deprecated, message: "Use Autogen.BankAPI.Account.IdentifyIndividual instead. This hand-written request is being replaced by the auto-generated Autogen API.")
    struct IdentifyIndividual: BankRequest {
        public let signature: String
        public let signingCert: String
        public let expectedHash: String
        public let name: String?
        public let gender: String?
        public let address: String?
        public let dateOfBirth: String?
        public let accountId: String

        public typealias Response = IdentificationResult

        public init(signature: String, signingCert: String, expectedHash: String, name: String? = nil, gender: String? = nil, address: String? = nil, dateOfBirth: String? = nil, accountId: String) {
            self.signature = signature
            self.signingCert = signingCert
            self.expectedHash = expectedHash
            self.name = name
            self.gender = gender
            self.address = address
            self.dateOfBirth = dateOfBirth
            self.accountId = accountId
        }

        public var method: HTTPMethod {
            return .post
        }

        public var path: String {
            return "/accounts/\(accountId)/individual-numbers/identification"
        }

        public var parameters: Any? {
            var dict: [String: Any] = [:]

            dict["signature"] = signature

            dict["signing_cert"] = signingCert

            dict["expected_hash"] = expectedHash

            if name != nil {
                dict["name"] = name
            }

            if gender != nil {
                dict["gender"] = gender
            }

            if address != nil {
                dict["address"] = address
            }

            if dateOfBirth != nil {
                dict["date_of_birth"] = dateOfBirth
            }

            return dict
        }
    }
}
