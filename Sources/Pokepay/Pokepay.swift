import KeychainAccess
import APIKit
import Result

public struct Pokepay {
    public struct Client {
        let isMerchant: Bool

        public init(isMerchant: Bool = false) {
            self.isMerchant = isMerchant
        }

        public func createToken(_ amount: Double, description: String? = nil, expiresIn: Int32? = nil,
                                handler: @escaping (Result<String, SessionTaskError>) -> Void = { _ in }) {
            let request = BankAPI.Cashtray.Create(amount: amount, description: description, expiresIn: expiresIn)
            Session.send(request) { result in
                switch result {
                case .success(let cashtray):
                    handler(.success("\(WWW_BASE_URL)/cashtrays/\(cashtray.id)"))
                case .failure(let error):
                    handler(.failure(error))
                }
            }
        }
    }

    public static func setup(accessToken: String) {
        let keychain = Keychain(service: "jp.pocket-change.pay")
        keychain["accessToken"] = accessToken
    }
}
