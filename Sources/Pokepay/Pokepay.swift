import KeychainAccess
import APIKit
import Result

public struct Pokepay {
    public static func setup(accessToken: String) {
        let keychain = Keychain(service: "jp.pocket-change.pay")
        keychain["accessToken"] = accessToken
    }

    public static func createToken(_ amount: Double, description: String? = nil, expiresIn: Int32? = nil,
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
