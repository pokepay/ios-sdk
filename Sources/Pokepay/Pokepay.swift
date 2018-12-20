import Foundation
import APIKit
import Result

public enum PokepayError: Error {
    case invalidToken
    case connectionError(Error)
    case requestError(Error)
    case responseError(Error)
    case bleError(Error)
}

public struct Pokepay {

    public enum TokenInfo {
        case cashtray(BankAPI.Cashtray.Get.Response)
        case bill(BankAPI.Bill.Get.Response)
        case check(BankAPI.Check.Get.Response)
        case pokeregi
    }

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

        public func send<T: APIKit.Request>(_ request: T, handler: @escaping (Result<T.Response, PokepayError>) -> Void) {
            let request = AuthorizedRequest(request: request, accessToken: accessToken, endpoint: apiBaseURL)
            Session.send(request) { result in
                switch result {
                case .success(let data):
                    handler(.success(data))
                case .failure(let error):
                    switch error {
                    case .connectionError(let error):
                        handler(.failure(PokepayError.connectionError(error)))
                    case .requestError(let error):
                        handler(.failure(PokepayError.requestError(error)))
                    case .responseError(let error):
                        handler(.failure(PokepayError.responseError(error)))
                    }
                }
            }
        }

        public func getTerminalInfo(handler: @escaping (Result<Terminal, PokepayError>) -> Void = { _ in }) {
            send(BankAPI.Terminal.Get(), handler: handler)
        }

        public func getTokenInfo(_ token: String,
                                 handler: @escaping (Result<TokenInfo, PokepayError>) -> Void) {
            if token.hasPrefix("\(wwwBaseURL)/cashtrays/") {
                let id = String(token.suffix(token.utf8.count - "\(wwwBaseURL)/cashtrays/".utf8.count))
                send(BankAPI.Cashtray.Get(id: id)) { result in
                    switch result {
                    case .success(let data):
                        handler(.success(TokenInfo.cashtray(data)))
                    case .failure(let error):
                        handler(.failure(error))
                    }
                }
            }
            else if token.hasPrefix("\(wwwBaseURL)/bills/") {
                let id = String(token.suffix(token.utf8.count - "\(wwwBaseURL)/bills/".utf8.count))
                send(BankAPI.Bill.Get(id: id)) { result in
                    switch result {
                    case .success(let data):
                        handler(.success(TokenInfo.bill(data)))
                    case .failure(let error):
                        handler(.failure(error))
                    }
                }
            }
            else if token.hasPrefix("\(wwwBaseURL)/checks/") {
                let id = String(token.suffix(token.utf8.count - "\(wwwBaseURL)/checks/".utf8.count))
                send(BankAPI.Check.Get(id: id)) { result in
                    switch result {
                    case .success(let data):
                        handler(.success(TokenInfo.check(data)))
                    case .failure(let error):
                        handler(.failure(error))
                    }
                }
            }
            else if token.range(of: "^[A-Z0-9]{25}$", options: NSString.CompareOptions.regularExpression, range: nil, locale: nil) != nil {
                handler(.success(TokenInfo.pokeregi))
            }
            else {
                handler(.failure(PokepayError.invalidToken))
            }
        }

        private func bleScanToken(_ token: String,  handler: @escaping (Result<UserTransaction, PokepayError>) -> Void = { _ in }) {
            let ble = BLEController()
            ble.scanToken(token: token) { result in
                switch result {
                case .success(let jwt):
                    self.send(BankAPI.Transaction.CreateWithJwt(data: jwt)) { result in
                        switch result {
                        case .success(let response):
                            if response.data != nil {
                                let responseData = response.data!
                                do {
                                    let ut: UserTransaction = try response.parseAsUserTransaction()
                                    ble.writeResult(response: responseData) { result in
                                        ble.stop()
                                        switch result {
                                        case .success(_):
                                            handler(.success(ut))
                                        case .failure(let error):
                                            handler(.failure(PokepayError.bleError(error)))
                                        }
                                    }
                                } catch let error {
                                    ble.stop()
                                    handler(.failure(PokepayError.responseError(error)))
                                }
                            } else if response.error != nil {
                                let responseError = response.error!
                                do {
                                    let ae: APIError = try response.parseAsAPIError()
                                    ble.writeResult(response: responseError) { result in
                                        ble.stop()
                                        switch result {
                                        case .success(_):
                                            handler(.failure(PokepayError.responseError(BankAPIError.unknownError(ae))))
                                        case .failure(let error):
                                            handler(.failure(PokepayError.bleError(error)))
                                        }
                                    }
                                } catch let error {
                                    ble.stop()
                                    handler(.failure(PokepayError.responseError(error)))
                                }
                            } else {
                                ble.stop()
                                let tmpJSON:String = "{\"type\":\"Invalid JSON structure\",\"message\":\"jwt response doesn't have neither data nor error.\"}"
                                let ae: BankAPIError = BankAPIError.init(object: tmpJSON.data(using: String.Encoding.utf8)!)
                                handler(.failure(PokepayError.responseError(ae)))
                            }
                        case .failure(let error):
                            ble.stop()
                            handler(.failure(error))
                        }
                    }
                case .failure(let error):
                    ble.stop()
                    let e = PokepayError.bleError(error)
                    handler(.failure(e))
                }
            }
        }

        public func scanToken(_ token: String, amount: Double? = nil,
                              handler: @escaping (Result<UserTransaction, PokepayError>) -> Void = { _ in }) {
            if token.hasPrefix("\(wwwBaseURL)/cashtrays/") {
                let uuid = String(token.suffix(token.utf8.count - "\(wwwBaseURL)/cashtrays/".utf8.count))
                send(BankAPI.Transaction.CreateWithCashtray(cashtrayId: uuid), handler: handler)
            }
            else if token.hasPrefix("\(wwwBaseURL)/bills/") {
                let uuid = String(token.suffix(token.utf8.count - "\(wwwBaseURL)/bills/".utf8.count))
                send(BankAPI.Transaction.CreateWithBill(billId: uuid, amount: amount), handler: handler)
            }
            else if token.hasPrefix("\(wwwBaseURL)/checks/") {
                let uuid = String(token.suffix(token.utf8.count - "\(wwwBaseURL)/checks/".utf8.count))
                send(BankAPI.Transaction.CreateWithCheck(checkId: uuid), handler: handler)
            }
            else if token.range(of: "^[A-Z0-9]{25}$", options: NSString.CompareOptions.regularExpression, range: nil, locale: nil) != nil {
                bleScanToken(token, handler: handler)
            }
            else {
                handler(.failure(PokepayError.invalidToken))
            }
        }

        public func createToken(_ amount: Double? = nil, description: String? = nil, expiresIn: Int32? = nil,
                                handler: @escaping (Result<String, PokepayError>) -> Void = { _ in }) {
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

        public func send<T: APIKit.Request>(_ request: T, handler: @escaping (Result<T.Response, PokepayError>) -> Void) {
            let request = OAuthEnvRequest(request: request, endpoint: wwwBaseURL)
            Session.send(request) { result in
                switch result {
                case .success(let data):
                    handler(.success(data))
                case .failure(let error):
                    switch error {
                    case .connectionError(let error):
                        handler(.failure(PokepayError.connectionError(error)))
                    case .requestError(let error):
                        handler(.failure(PokepayError.requestError(error)))
                    case .responseError(let error):
                        handler(.failure(PokepayError.responseError(error)))
                    }
                }
            }
        }

        public func getAuthorizationUrl() -> String {
            return "\(wwwBaseURL)/oauth/authorize?client_id=\(clientId)&response_type=code"
        }

        public func getAccessToken(code: String,
                                   handler: @escaping (Result<AccessToken, PokepayError>) -> Void = { _ in }) {
            send(OAuthAPI.Token.ExchangeAuthCode(code: code, clientId: clientId, clientSecret: clientSecret), handler: handler)
        }

        public func refreshAccessToken(refreshToken: String,
                                       handler: @escaping (Result<AccessToken, PokepayError>) -> Void = { _ in }) {
            send(OAuthAPI.Token.RefreshAccessToken(refreshToken: refreshToken, clientId: clientId, clientSecret: clientSecret), handler: handler)
        }
    }
}
