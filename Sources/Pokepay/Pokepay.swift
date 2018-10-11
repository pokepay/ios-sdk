import Foundation
import APIKit
import Result

public struct Pokepay {
    public struct Client {
        let accessToken: String
        let isMerchant: Bool
        let env: Env

        public var wwwBaseURL: URL {
            switch env {
            case .production:
                return URL(string: "https://www.pokepay.jp")!
            default:
                return URL(string: "https://www-\(env.rawValue).pokepay.jp")!
            }
        }

        public var apiBaseURL: URL {
            switch env {
            case .production:
                return URL(string: "https://api.pokepay.jp")!
            default:
                return URL(string: "https://api-\(env.rawValue).pokepay.jp")!
            }
        }

        public init(accessToken: String, isMerchant: Bool = false, env: Env = .development) {
            self.accessToken = accessToken
            self.isMerchant = isMerchant
            self.env = env
        }

        public func send<T: APIKit.Request>(_ request: T, handler: @escaping (Result<T.Response, SessionTaskError>) -> Void) {
            let request = AuthorizedRequest(request: request, accessToken: accessToken, endpoint: apiBaseURL)
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
            if token.hasPrefix("\(wwwBaseURL)/cashtrays/") {
                let uuid = String(token.suffix(token.utf8.count - "\(wwwBaseURL)/cashtrays/".utf8.count))
                send(BankAPI.Transaction.CreateWithCashtray(cashtrayId: uuid)) { result in
                    handler(result)
                }
            }
            else if token.hasPrefix("\(wwwBaseURL)/bills/") {
                let uuid = String(token.suffix(token.utf8.count - "\(wwwBaseURL)/bills/".utf8.count))
                send(BankAPI.Transaction.CreateWithBill(billId: uuid, amount: amount)) { result in
                    handler(result)
                }
            }
            else if token.hasPrefix("\(wwwBaseURL)/checks/") {
                let uuid = String(token.suffix(token.utf8.count - "\(wwwBaseURL)/checks/".utf8.count))
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
                            handler(.success("\(self.wwwBaseURL)/cashtrays/\(cashtray.id)"))
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
                            handler(.success("\(self.wwwBaseURL)/bills/\(bill.id)"))
                        case .failure(let error):
                            handler(.failure(error))
                        }
                    }
                }
                else {
                    send(BankAPI.Check.Create(amount: amount, description: description)) { result in
                        switch result {
                        case .success(let check):
                            handler(.success("\(self.wwwBaseURL)/checks/\(check.id)"))
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
                        handler(.success("\(self.wwwBaseURL)/bills/\(bill.id)"))
                    case .failure(let error):
                        handler(.failure(error))
                    }
                }
            }
        }
    }
    public struct OAuthClient {
        let clientId: String
        let clientSecret: String
        let env: Env

        public var wwwBaseURL: URL {
            switch env {
            case .production:
                return URL(string: "https://www.pokepay.jp")!
            default:
                return URL(string: "https://www-\(env.rawValue).pokepay.jp")!
            }
        }

        public init(clientId: String, clientSecret: String, env: Env = .development) {
            self.clientId = clientId
            self.clientSecret = clientSecret
            self.env = env
        }

        public func send<T: APIKit.Request>(_ request: T, handler: @escaping (Result<T.Response, SessionTaskError>) -> Void) {
            let request = OAuthEnvRequest(request: request, endpoint: wwwBaseURL)
            Session.send(request) { result in handler(result) }
        }

        public func getAuthorizationUrl() -> String {
            return "\(wwwBaseURL)/oauth/authorize?client_id=\(clientId)&response_type=code"
        }

        public func getAccessToken(code: String,
                                   handler: @escaping (Result<AccessToken, SessionTaskError>) -> Void = { _ in }) {
            send(OAuthAPI.Token.ExchangeAuthCode(code: code, clientId: clientId, clientSecret: clientSecret)) { result in handler(result) }
        }
    }
}
