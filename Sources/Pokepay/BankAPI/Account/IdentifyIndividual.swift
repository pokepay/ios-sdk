import APIKit
import Foundation

public extension BankAPI.Account {
    struct IdentifyIndividual: BankRequest {
        public let accountId: String
        public let signature: String
        public let signingCert: String
        public let expectedHash: String
        public let name: String?
        public let gender: Gender?
        public let address: String?
        /// pattern = YYYY-MM-DD
        public let dateOfBirth: String?
        public typealias Response = IdentificationResult

        public init(accountId: String, signature: String, signingCert: String, expectedHash: String, name: String? = nil, gender: Gender? = nil, address: String? = nil, dateOfBirth: String? = nil) {
            self.accountId = accountId
            self.signature = signature
            self.signingCert = signingCert
            self.expectedHash = expectedHash
            self.name = name
            self.gender = gender
            self.address = address
            self.dateOfBirth = dateOfBirth
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