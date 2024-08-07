import Foundation
import APIKit
import Result

private extension String {
    func capture(pattern: String, group: Int) -> String? {
        let result = capture(pattern: pattern, group: [group])
        return result.isEmpty ? nil : result[0]
    }
    func capture(pattern: String, group: [Int]) -> [String] {
        guard let regex = try? NSRegularExpression(pattern: pattern) else {
            return []
        }
        guard let matched = regex.firstMatch(in: self, range: NSRange(location: 0, length: self.count)) else {
            return []
        }
        return group.map { group -> String in
            return (self as NSString).substring(with: matched.range(at: group))
        }
    }
}

public enum PokepayError: Error {
    case invalidToken
    case connectionError(Error)
    case requestError(Error)
    case responseError(Error)
    case bleError(Error)
}

public struct Pokepay {

    public struct Client {
        let accessToken: String
        let isMerchant: Bool
        let env: Env
        var customDomain: String?;

        public var wwwBaseURL: URL {
            if let customDomain = self.customDomain {
                return URL(string: customDomain)!
            }
            return defaultWwwBaseURL
        }
        
        public var defaultWwwBaseURL: URL {
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

        public init(accessToken: String, isMerchant: Bool = false, env: Env = .development, customDomain: String? = nil) {
            self.accessToken = accessToken
            self.isMerchant = isMerchant
            self.env = env
            self.customDomain = customDomain
        }
        
        /**
         Create a client object with custom domain.
         
         - warning
         It is encouraged to get the client once and use it throughout the application since this method needs to call api endpoint to get a custom domain.
        */
        public static func withCustomDomain(accessToken: String, isMerchant: Bool = false, env: Env = .development, challange: String, handler: @escaping (Result<Client, PokepayError>) -> Void = { _ in }) {
            let client = Client(accessToken: accessToken, isMerchant: true, env: env)
            client.send(BankAPI.PrivateMoney.GetPrivateMoney(privateMoneyId: challange)) { result in
                switch result {
                    case .success(let response):
                        handler(
                            .success(Pokepay.Client(
                                accessToken: accessToken, isMerchant: isMerchant, env: env, customDomain: response.customDomainName
                            ))
                        )
                    case .failure(let error):
                        handler(.failure(error))
                }

            }
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

        public func parseAsPokeregiToken(_ token: String) -> (matched: Bool, key: String) {
            if let group = token.capture(
                // * {25 ALNUM} - (Pokeregi_V1 OfflineMode QR)
                pattern: "^([A-Z0-9]{25})$", group: 1) {
                return (matched: true, key: group)
            }
            if let group = token.capture(
                // * https://www.pokepay.jp/pd?={25 ALNUM} - (Pokeregi_V1 OfflineMode NFC)
                // * https://www.pokepay.jp/pd/{25 ALNUM} - (Pokeregi_V2 OfflineMode QR & NFC)
                pattern: "^https://www(?:-dev|-sandbox|-qa|)\\.pokepay\\.jp/pd(?:/|\\?d=)([0-9A-Z]{25})$", group: 1) {
                return (matched: true, key: group)
            }
            return (matched: false, key: "")
        }

        public func getTokenInfo(_ token: String,
                                 handler: @escaping (Result<TokenInfo, PokepayError>) -> Void) {
            let baseUrl = token.hasPrefix("\(wwwBaseURL)") ? wwwBaseURL : defaultWwwBaseURL
            if token.hasPrefix("\(baseUrl)/cashtrays/") {
                handler(.success(TokenInfo.cashtray("")))
            }
            else if token.hasPrefix("\(baseUrl)/bills/") {
                let id = String(token.suffix(token.utf8.count - "\(baseUrl)/bills/".utf8.count))
                send(BankAPI.Bill.Get(id: id)) { result in
                    switch result {
                    case .success(let data):
                        handler(.success(TokenInfo.bill(data)))
                    case .failure(let error):
                        handler(.failure(error))
                    }
                }
            }
            else if token.hasPrefix("\(baseUrl)/checks/") {
                let id = String(token.suffix(token.utf8.count - "\(baseUrl)/checks/".utf8.count))
                send(BankAPI.Check.Get(id: id)) { result in
                    switch result {
                    case .success(let data):
                        handler(.success(TokenInfo.check(data)))
                    case .failure(let error):
                        handler(.failure(error))
                    }
                }
            }
            else if token.range(of: "^[0-9]{20}$", options: NSString.CompareOptions.regularExpression, range: nil, locale: nil) != nil {
                send(BankAPI.CpmToken.Get(cpmToken: token)) { result in
                    switch result {
                    case .success(let data):
                        handler(.success(TokenInfo.cpm(data)))
                    case .failure(let error):
                        handler(.failure(error))
                    }
                }
            }
            else if parseAsPokeregiToken(token).matched {
                handler(.success(TokenInfo.pokeregi("")))
            }
            else {
                handler(.failure(PokepayError.invalidToken))
            }
        }

        private func bleScanToken(_ token: String, couponId: String? = nil, strategy: TransactionStrategy? = .pointPreferred, handler: @escaping (Result<UserTransaction, PokepayError>) -> Void = { _ in }) {
            let ble = BLEController()
            ble.scanToken(token: token) { result in
                switch result {
                case .success(let jwt):
                    self.send(BankAPI.Transaction.CreateWithJwt(data: jwt, couponId: couponId, strategy: strategy)) { result in
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
                                            handler(.failure(PokepayError.responseError(BankAPIError.unknownError(0, ae))))
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

        public func scanToken(_ token: String, amount: Double? = nil, accountId: String? = nil, products: [Product]? = nil, couponId: String? = nil, strategy: TransactionStrategy? = .pointPreferred, requestId: UUID? = nil,
                              handler: @escaping (Result<UserTransaction, PokepayError>) -> Void = { _ in }) {
            let baseUrl = token.hasPrefix("\(wwwBaseURL)") ? wwwBaseURL : defaultWwwBaseURL
            if token.hasPrefix("\(baseUrl)/cashtrays/") {
                let uuid = String(token.suffix(token.utf8.count - "\(baseUrl)/cashtrays/".utf8.count))
                send(BankAPI.Transaction.CreateWithCashtray(cashtrayId: uuid,accountId: accountId,couponId: couponId, strategy: strategy, requestId: requestId), handler: handler)
            }
            else if token.hasPrefix("\(baseUrl)/bills/") {
                let uuid = String(token.suffix(token.utf8.count - "\(baseUrl)/bills/".utf8.count))
                send(BankAPI.Transaction.CreateWithBill(billId: uuid, accountId: accountId, amount: amount,couponId: couponId, strategy: strategy, requestId: requestId), handler: handler)
            }
            else if token.hasPrefix("\(baseUrl)/checks/") {
                let uuid = String(token.suffix(token.utf8.count - "\(baseUrl)/checks/".utf8.count))
                send(BankAPI.Transaction.CreateWithCheck(checkId: uuid, accountId: accountId, requestId: requestId), handler: handler)
            }
            else if token.range(of: "^[0-9]{20}$", options: NSString.CompareOptions.regularExpression, range: nil, locale: nil) != nil {
                send(BankAPI.Transaction.CreateWithCpm(cpmToken: token, accountId: accountId, amount: amount ?? 0.0, products: products, requestId: requestId), handler: handler)
            }
            else {
                let pokeregiToken = parseAsPokeregiToken(token)
                if pokeregiToken.matched {
                    bleScanToken(pokeregiToken.key, couponId: couponId, handler: handler)
                } else {
                    handler(.failure(PokepayError.invalidToken))
                }
            }
        }

        public func createToken(_ amount: Double? = nil, description: String? = nil, expiresIn: Int32? = nil, accountId: String? = nil, products: [Product]? = nil, checkExpiresAt: Date? = nil,
                                handler: @escaping (Result<String, PokepayError>) -> Void = { _ in }) {
            if isMerchant {
                if let amount = amount {
                    send(BankAPI.Cashtray.Create(amount: amount, description: description, expiresIn: expiresIn, products: products)) { result in
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
                    send(BankAPI.Bill.Create(amount: -amount, accountId: accountId, description: description, products: products)) { result in
                        switch result {
                        case .success(let bill):
                            handler(.success("\(self.wwwBaseURL)/bills/\(bill.id)"))
                        case .failure(let error):
                            handler(.failure(error))
                        }
                    }
                }
                else {
                    send(BankAPI.Check.Create(amount: amount, accountId: accountId, description: description, expiresAt: checkExpiresAt)) { result in
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
                send(BankAPI.Bill.Create(amount: nil, accountId: accountId, description: description, products: products)) { result in
                    switch result {
                    case .success(let bill):
                        handler(.success("\(self.wwwBaseURL)/bills/\(bill.id)"))
                    case .failure(let error):
                        handler(.failure(error))
                    }
                }
            }
        }
        
        public func getUserSettingUrl(handler: @escaping (Result<UserSettingUrl, PokepayError>) -> Void = { _ in }) {
            send(BankAPI.User.GetUserSettingUrl(accessCode: accessToken), handler: handler)
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

        public func getAuthorizationUrl(contact: String? = nil) -> String {
            let url = "\(wwwBaseURL)/oauth/authorize?client_id=\(clientId)&response_type=code"
            guard let contact = contact else {
                return url
            }
            let encodedContact = contact.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.alphanumerics)
            precondition(encodedContact != nil)
            return "\(url)&contact=\(encodedContact!)"
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
    
    public struct VeritransClient {
        
        public init() {}
        
        public func send<T: APIKit.Request>(_ request: T, handler: @escaping (Result<T.Response, PokepayError>) -> Void) {
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
    }
}
