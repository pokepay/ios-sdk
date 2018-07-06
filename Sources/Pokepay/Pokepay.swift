import KeychainAccess
import APIKit
import Result

public struct Pokepay {
    public struct Client {
        let isMerchant: Bool

        public init(isMerchant: Bool = false) {
            self.isMerchant = isMerchant
        }

        public func createToken(_ amount: Double? = nil, description: String? = nil, expiresIn: Int32? = nil,
                                handler: @escaping (Result<String, SessionTaskError>) -> Void = { _ in }) {
            if isMerchant {
                if let amount = amount {
                    Session.send(BankAPI.Cashtray.Create(amount: amount, description: description, expiresIn: expiresIn)) { result in
                        switch result {
                        case .success(let cashtray):
                            handler(.success("\(WWW_BASE_URL)/cashtrays/\(cashtray.id)"))
                        case .failure(let error):
                            handler(.failure(error))
                        }
                    }
                }
                else {
                    assert(false)
                }
            }
            else if let amount = amount {
                if amount < 0 {
                    Session.send(BankAPI.Bill.Create(amount: -amount, description: description)) { result in
                        switch result {
                        case .success(let bill):
                            handler(.success("\(WWW_BASE_URL)/bills/\(bill.id)"))
                        case .failure(let error):
                            handler(.failure(error))
                        }
                    }
                }
                else {
                    Session.send(BankAPI.Check.Create(amount: amount, description: description)) { result in
                        switch result {
                        case .success(let check):
                            handler(.success("\(WWW_BASE_URL)/checks/\(check.id)"))
                        case .failure(let error):
                            handler(.failure(error))
                        }
                    }
                }
            }
            else {
                Session.send(BankAPI.Bill.Create(amount: nil, description: description)) { result in
                    switch result {
                    case .success(let bill):
                        handler(.success("\(WWW_BASE_URL)/bills/\(bill.id)"))
                    case .failure(let error):
                        handler(.failure(error))
                    }
                }
            }
        }
    }

    public static func setup(accessToken: String) {
        let keychain = Keychain(service: "jp.pocket-change.pay")
        keychain["accessToken"] = accessToken
    }
}
