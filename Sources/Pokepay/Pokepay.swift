import APIKit
import Result

public struct Pokepay {
    public struct Client {
        let accessToken: String
        let isMerchant: Bool

        public init(accessToken: String, isMerchant: Bool = false) {
            self.accessToken = accessToken
            self.isMerchant = isMerchant
        }

        public func send<T: APIKit.Request>(_ request: T, handler: @escaping (Result<T.Response, SessionTaskError>) -> Void) {
            let request = AuthorizedRequest(request: request, accessToken: accessToken)
            Session.send(request) { result in handler(result) }
        }

        public func getTerminalInfo(handler: @escaping (Result<Terminal, SessionTaskError>) -> Void = { _ in }) {
            send(BankAPI.Terminal.Get()) { result in
                switch result {
                case .success(let terminal):
                    handler(.success(terminal))
                case .failure(let error):
                    handler(.failure(error))
                }
            }
        }

        public func scanToken(_ token: String, amount: Double? = nil,
                              handler: @escaping (Result<UserTransaction, SessionTaskError>) -> Void = { _ in }) {
            if token.hasPrefix("\(WWW_BASE_URL)/cashtrays/") {
                let uuid = String(token.suffix(token.utf8.count - "\(WWW_BASE_URL)/cashtrays/".utf8.count))
                send(BankAPI.Transaction.CreateWithCashtray(cashtrayId: uuid)) { result in
                    handler(result)
                }
            }
            else if token.hasPrefix("\(WWW_BASE_URL)/bills/") {
                let uuid = String(token.suffix(token.utf8.count - "\(WWW_BASE_URL)/bills/".utf8.count))
                send(BankAPI.Transaction.CreateWithBill(billId: uuid, amount: amount)) { result in
                    handler(result)
                }
            }
            else if token.hasPrefix("\(WWW_BASE_URL)/checks/") {
                let uuid = String(token.suffix(token.utf8.count - "\(WWW_BASE_URL)/checks/".utf8.count))
                send(BankAPI.Transaction.CreateWithCheck(checkId: uuid)) { result in
                    handler(result)
                }
            }
            else {
                // Invalid token
                assert(false)
            }
        }

        public func createToken(_ amount: Double? = nil, description: String? = nil, expiresIn: Int32? = nil,
                                handler: @escaping (Result<String, SessionTaskError>) -> Void = { _ in }) {
            if isMerchant {
                if let amount = amount {
                    send(BankAPI.Cashtray.Create(amount: amount, description: description, expiresIn: expiresIn)) { result in
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
                    send(BankAPI.Bill.Create(amount: -amount, description: description)) { result in
                        switch result {
                        case .success(let bill):
                            handler(.success("\(WWW_BASE_URL)/bills/\(bill.id)"))
                        case .failure(let error):
                            handler(.failure(error))
                        }
                    }
                }
                else {
                    send(BankAPI.Check.Create(amount: amount, description: description)) { result in
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
                send(BankAPI.Bill.Create(amount: nil, description: description)) { result in
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
}
