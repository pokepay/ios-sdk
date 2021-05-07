import Flutter
import UIKit
import APIKit
import Result

private class APIJSONEncoder : JSONEncoder {
    override init() {
        super.init()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS'Z'"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        dateEncodingStrategy = .formatted(dateFormatter)
    }
}

private struct APIRequestError:Codable {
    public let statusCode: Int
    public let error: APIError
    private enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case error
    }
}

private struct OAuthRequestError:Codable {
    public let statusCode: Int
    public let error: OAuthError
    private enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case error
    }
}

private struct ProcessingError:Codable {
    public let message: String
    private enum CodingKeys: String, CodingKey {
        case message
    }
}

private class MethodCallTask {
    private var call: FlutterMethodCall;
    private var result: FlutterResult;
    init(c: FlutterMethodCall, r: @escaping FlutterResult) {
        call = c;
        result = r;
    }
    private func flutterEnvToSDKEnv(ienv: Int32) -> Env {
        switch ienv {
            case 0: return Env.production;
            case 1: return Env.sandbox;
            case 2: return Env.qa;
            case 3: return Env.development;
            default: return Env.development;
        }
    }
    private func stringToDate(s: String?) -> Date? {
        if (s == nil) {
            return nil;
        }
        return BankAPIJSONDecoder.dateFormatter.date(from: s!)
    }
    private func apiRequestError(code: Int, apiError: APIError) {
        let bytes = try! APIJSONEncoder().encode(APIRequestError(statusCode: code, error: apiError))
        let err = String(data: bytes, encoding: .utf8)
        self.result(
            FlutterError(code: "APIRequestError", message: err, details: nil)
        )
    }
    private func oauthRequestError(code: Int, oauthError: OAuthError) {
        let bytes = try! APIJSONEncoder().encode(OAuthRequestError(statusCode: code, error: oauthError))
        let err = String(data: bytes, encoding: .utf8)
        self.result(
            FlutterError(code: "OAuthRequestError", message: err, details: nil)
        )
    }
    private func processingError(message: String) {
        let bytes = try! APIJSONEncoder().encode(ProcessingError(message: message))
        let err = String(data: bytes, encoding: .utf8)
        self.result(
            FlutterError(code: "ProcessingError", message: err, details: nil)
        )
    }
    private func after<T: Codable>(_ ret: Result<T, PokepayError>) -> Void {
        switch ret {
        case .success(let ret):
           let bytes = try! APIJSONEncoder().encode(ret)
           self.result(String(data: bytes, encoding: .utf8))
        case .failure(.responseError(let error as BankAPIError)):
           switch error {
           case .clientError(let code, let apiError):
               self.apiRequestError(code: code, apiError: apiError)
           case .serverError(let code, let apiError):
               self.apiRequestError(code: code, apiError: apiError)
           case .unknownError(let code, let apiError):
               self.apiRequestError(code: code, apiError: apiError)
           case .invalidJSON(let swiftError):
               self.processingError(message: swiftError.localizedDescription)
           }
        case .failure(.responseError(let error as OAuthAPIError)):
           switch error {
           case .clientError(let code, let oauthError, _):
               self.oauthRequestError(code: code, oauthError: oauthError)
           case .serverError(let code, let oauthError, _):
               self.oauthRequestError(code: code, oauthError: oauthError)
           case .unknownError(let code, let oauthError, _):
               self.oauthRequestError(code: code, oauthError: oauthError)
           case .invalidJSON(let swiftError):
               self.processingError(message: swiftError.localizedDescription)
           }
        case .failure(let e):
           self.processingError(message: e.localizedDescription)
        }
    }
    public func invokeMethod() {
        guard let _args = call.arguments,
            let args = _args as? [String: Any] else { return }
        switch call.method {
        case "addTerminalPublicKey":
            let env = flutterEnvToSDKEnv(ienv: args["env"] as! Int32)
            let accessToken = args["accessToken"] as! String
            let client = Pokepay.Client(accessToken: accessToken, env: env)
            let key = args["key"] as! String
            client.send(BankAPI.Terminal.AddPublicKey(key: key), handler: self.after)
        case "cancelUserTransaction":
            let env = flutterEnvToSDKEnv(ienv: args["env"] as! Int32)
            let accessToken = args["accessToken"] as! String
            let client = Pokepay.Client(accessToken: accessToken, env: env)
            let id = args["id"] as! String
            client.send(BankAPI.Transaction.Cancel(id: id), handler: self.after)
        case "createAccount":
            let env = flutterEnvToSDKEnv(ienv: args["env"] as! Int32)
            let accessToken = args["accessToken"] as! String
            let client = Pokepay.Client(accessToken: accessToken, env: env)
            let name = args["name"] as? String
            let privateMoneyId = args["privateMoneyId"] as? String
            client.send(BankAPI.Account.Create(name: name, privateMoneyId: privateMoneyId), handler: self.after)
        case "createAccountCpmToken":
            let env = flutterEnvToSDKEnv(ienv: args["env"] as! Int32)
            let accessToken = args["accessToken"] as! String
            let client = Pokepay.Client(accessToken: accessToken, env: env)
            let accountId = args["accountId"] as! String
            let scopes = args["scopes"] as! Int
            let expiresIn = args["expiresIn"] as? Int
            let additionalInfo = args["additionalInfo"] as? String
            client.send(BankAPI.Account.CreateAccountCpmToken(accountId: accountId, scopes: BankAPI.Account.CreateAccountCpmToken.Scope(rawValue: scopes)!, expiresIn: expiresIn, additionalInfo: additionalInfo), handler: self.after)
        case "createBill":
            let env = flutterEnvToSDKEnv(ienv: args["env"] as! Int32)
            let accessToken = args["accessToken"] as! String
            let client = Pokepay.Client(accessToken: accessToken, env: env)
            let amount = args["amount"] as? Double
            let accountId = args["accountId"] as? String
            let description = args["description"] as? String
            let isOnetime = args["isOnetime"] as! Bool
            let productsString = (args["products"] as! String).data(using: .utf8)!
            let products = try! BankAPIJSONDecoder().decode([Product]?.self, from: productsString)
            client.send(BankAPI.Bill.Create(amount: amount, accountId: accountId, description: description, isOnetime: isOnetime, products: products), handler: self.after)
        case "createCashtray":
            let env = flutterEnvToSDKEnv(ienv: args["env"] as! Int32)
            let accessToken = args["accessToken"] as! String
            let client = Pokepay.Client(accessToken: accessToken, env: env)
            let amount = args["amount"] as! Double
            let description = args["description"] as? String
            let expiresIn = args["expiresIn"] as? Int32
            let productsString = (args["products"] as! String).data(using: .utf8)!
            let products = try! BankAPIJSONDecoder().decode([Product]?.self, from: productsString)
            client.send(BankAPI.Cashtray.Create(amount: amount, description: description, expiresIn: expiresIn, products: products), handler: self.after)
        case "createCheck":
            let env = flutterEnvToSDKEnv(ienv: args["env"] as! Int32)
            let accessToken = args["accessToken"] as! String
            let client = Pokepay.Client(accessToken: accessToken, env: env)
            let amount = args["amount"] as? Double
            let moneyAmount = args["moneyAmount"] as? Double
            let pointAmount = args["pointAmount"] as? Double
            let accountId = args["accountId"] as? String
            let description = args["description"] as? String
            let isOnetime = args["isOnetime"] as! Bool
            let usageLimit = args["usageLimit"] as? Int32
            let expiresAt = stringToDate(s: (args["expiresAt"] as? String))
            let pointExpiresAt = stringToDate(s: (args["pointExpiresAt"] as? String))
            let pointExpiresInDays = args["pointExpiresInDays"] as? Int32
            client.send(BankAPI.Check.Create(amount: amount, moneyAmount: moneyAmount, pointAmount: pointAmount, accountId: accountId, description: description, isOnetime: isOnetime, usageLimit: usageLimit, expiresAt: expiresAt, pointExpiresAt: pointExpiresAt, pointExpiresInDays: pointExpiresInDays), handler: self.after)
        case "createUserTransactionWithBill":
            let env = flutterEnvToSDKEnv(ienv: args["env"] as! Int32)
            let accessToken = args["accessToken"] as! String
            let client = Pokepay.Client(accessToken: accessToken, env: env)
            let billId = args["billId"] as! String
            let accountId = args["accountId"] as? String
            let amount = args["amount"] as? Double
            client.send(BankAPI.Transaction.CreateWithBill(billId: billId, accountId: accountId, amount: amount), handler: self.after)
        case "createUserTransactionWithCashtray":
            let env = flutterEnvToSDKEnv(ienv: args["env"] as! Int32)
            let accessToken = args["accessToken"] as! String
            let client = Pokepay.Client(accessToken: accessToken, env: env)
            let cashtrayId = args["cashtrayId"] as! String
            let accountId = args["accountId"] as? String
            client.send(BankAPI.Transaction.CreateWithCashtray(cashtrayId: cashtrayId, accountId: accountId), handler: self.after)
        case "createUserTransactionWithCheck":
            let env = flutterEnvToSDKEnv(ienv: args["env"] as! Int32)
            let accessToken = args["accessToken"] as! String
            let client = Pokepay.Client(accessToken: accessToken, env: env)
            let checkId = args["checkId"] as! String
            let accountId = args["accountId"] as? String
            client.send(BankAPI.Transaction.CreateWithCheck(checkId: checkId, accountId: accountId), handler: self.after)
        case "createUserTransactionWithCpm":
            let env = flutterEnvToSDKEnv(ienv: args["env"] as! Int32)
            let accessToken = args["accessToken"] as! String
            let client = Pokepay.Client(accessToken: accessToken, env: env)
            let cpmToken = args["cpmToken"] as! String
            let accountId = args["accountId"] as? String
            let amount = args["amount"] as! Double
            let productsString = (args["products"] as! String).data(using: .utf8)!
            let products = try! BankAPIJSONDecoder().decode([Product]?.self, from: productsString)
            client.send(BankAPI.Transaction.CreateWithCpm(cpmToken: cpmToken, accountId: accountId, amount: amount, products: products), handler: self.after)
        case "createUserTransactionWithJwt":
            let env = flutterEnvToSDKEnv(ienv: args["env"] as! Int32)
            let accessToken = args["accessToken"] as! String
            let client = Pokepay.Client(accessToken: accessToken, env: env)
            let data = args["data"] as! String
            let accountId = args["accountId"] as? String
            client.send(BankAPI.Transaction.CreateWithJwt(data: data, accountId: accountId), handler: self.after)
        case "deleteBill":
            let env = flutterEnvToSDKEnv(ienv: args["env"] as! Int32)
            let accessToken = args["accessToken"] as! String
            let client = Pokepay.Client(accessToken: accessToken, env: env)
            let id = args["id"] as! String
            client.send(BankAPI.Bill.Delete(id: id), handler: self.after)
        case "deleteCashtray":
            let env = flutterEnvToSDKEnv(ienv: args["env"] as! Int32)
            let accessToken = args["accessToken"] as! String
            let client = Pokepay.Client(accessToken: accessToken, env: env)
            let id = args["id"] as! String
            client.send(BankAPI.Cashtray.Delete(id: id), handler: self.after)
        case "deleteCheck":
            let env = flutterEnvToSDKEnv(ienv: args["env"] as! Int32)
            let accessToken = args["accessToken"] as! String
            let client = Pokepay.Client(accessToken: accessToken, env: env)
            let id = args["id"] as! String
            client.send(BankAPI.Check.Delete(id: id), handler: self.after)
        case "deleteUserEmail":
            let env = flutterEnvToSDKEnv(ienv: args["env"] as! Int32)
            let accessToken = args["accessToken"] as! String
            let client = Pokepay.Client(accessToken: accessToken, env: env)
            let id = args["id"] as! String
            let email = args["email"] as! String
            client.send(BankAPI.User.DeleteEmail(id: id, email: email), handler: self.after)
        case "exchangeAuthCode":
            let env = flutterEnvToSDKEnv(ienv: args["env"] as! Int32)
            let code = args["code"] as! String
            let clientId = args["clientId"] as! String
            let clientSecret = args["clientSecret"] as! String
            let grantType = args["grantType"] as! String
            let client = Pokepay.OAuthClient(clientId: clientId, clientSecret: clientSecret, env: env)
            client.send(OAuthAPI.Token.ExchangeAuthCode(code: code, clientId: clientId, clientSecret: clientSecret, grantType: grantType), handler: self.after)
        case "getAccount":
            let env = flutterEnvToSDKEnv(ienv: args["env"] as! Int32)
            let accessToken = args["accessToken"] as! String
            let client = Pokepay.Client(accessToken: accessToken, env: env)
            let id = args["id"] as! String
            client.send(BankAPI.Account.Get(id: id), handler: self.after)
        case "getAccountBalances":
            let env = flutterEnvToSDKEnv(ienv: args["env"] as! Int32)
            let accessToken = args["accessToken"] as! String
            let client = Pokepay.Client(accessToken: accessToken, env: env)
            let id = args["id"] as! String
            let before = args["before"] as? String
            let after = args["after"] as? String
            let perPage = args["perPage"] as? Int32
            client.send(BankAPI.Account.GetBalances(id: id, before: before, after: after, perPage: perPage), handler: self.after)
        case "getAccountTransactions":
            let env = flutterEnvToSDKEnv(ienv: args["env"] as! Int32)
            let accessToken = args["accessToken"] as! String
            let client = Pokepay.Client(accessToken: accessToken, env: env)
            let id = args["id"] as! String
            let before = args["before"] as? String
            let after = args["after"] as? String
            let perPage = args["perPage"] as? Int32
            client.send(BankAPI.Account.GetTransactions(id: id, before: before, after: after, perPage: perPage), handler: self.after)
        case "getBill":
            let env = flutterEnvToSDKEnv(ienv: args["env"] as! Int32)
            let accessToken = args["accessToken"] as! String
            let client = Pokepay.Client(accessToken: accessToken, env: env)
            let id = args["id"] as! String
            client.send(BankAPI.Bill.Get(id: id), handler: self.after)
        case "getCashtray":
            let env = flutterEnvToSDKEnv(ienv: args["env"] as! Int32)
            let accessToken = args["accessToken"] as! String
            let client = Pokepay.Client(accessToken: accessToken, env: env)
            let id = args["id"] as! String
            client.send(BankAPI.Cashtray.Get(id: id), handler: self.after)
        case "getCashtrayAttempts":
            let env = flutterEnvToSDKEnv(ienv: args["env"] as! Int32)
            let accessToken = args["accessToken"] as! String
            let client = Pokepay.Client(accessToken: accessToken, env: env)
            let id = args["id"] as! String
            client.send(BankAPI.Cashtray.GetAttempts(id: id), handler: self.after)
        case "getCheck":
            let env = flutterEnvToSDKEnv(ienv: args["env"] as! Int32)
            let accessToken = args["accessToken"] as! String
            let client = Pokepay.Client(accessToken: accessToken, env: env)
            let id = args["id"] as! String
            client.send(BankAPI.Check.Get(id: id), handler: self.after)
        case "getCpmToken":
            let env = flutterEnvToSDKEnv(ienv: args["env"] as! Int32)
            let accessToken = args["accessToken"] as! String
            let client = Pokepay.Client(accessToken: accessToken, env: env)
            let cpmToken = args["cpmToken"] as! String
            client.send(BankAPI.CpmToken.Get(cpmToken: cpmToken), handler: self.after)
        case "getMessage":
            let env = flutterEnvToSDKEnv(ienv: args["env"] as! Int32)
            let accessToken = args["accessToken"] as! String
            let client = Pokepay.Client(accessToken: accessToken, env: env)
            let id = args["id"] as! String
            client.send(MessagingAPI.Get(id: id), handler: self.after)
        case "getMessageUnreadCount":
            let env = flutterEnvToSDKEnv(ienv: args["env"] as! Int32)
            let accessToken = args["accessToken"] as! String
            let client = Pokepay.Client(accessToken: accessToken, env: env)
            client.send(MessagingAPI.GetUnreadCount(), handler: self.after)
        case "getTerminal":
            let env = flutterEnvToSDKEnv(ienv: args["env"] as! Int32)
            let accessToken = args["accessToken"] as! String
            let client = Pokepay.Client(accessToken: accessToken, env: env)
            client.send(BankAPI.Terminal.Get(), handler: self.after)
        case "getTokenInfo":
            // FIXME:
            self.result(FlutterMethodNotImplemented)
        case "getUserAccounts":
            let env = flutterEnvToSDKEnv(ienv: args["env"] as! Int32)
            let accessToken = args["accessToken"] as! String
            let client = Pokepay.Client(accessToken: accessToken, env: env)
            let id = args["id"] as! String
            let before = args["before"] as? String
            let after = args["after"] as? String
            let perPage = args["perPage"] as? Int32
            client.send(BankAPI.User.GetAccounts(id: id, before: before, after: after, perPage: perPage), handler: self.after)
        case "getUserTransaction":
            let env = flutterEnvToSDKEnv(ienv: args["env"] as! Int32)
            let accessToken = args["accessToken"] as! String
            let client = Pokepay.Client(accessToken: accessToken, env: env)
            let id = args["id"] as! String
            client.send(BankAPI.Transaction.Get(id: id), handler: self.after)
        case "getUserTransactions":
            let env = flutterEnvToSDKEnv(ienv: args["env"] as! Int32)
            let accessToken = args["accessToken"] as! String
            let client = Pokepay.Client(accessToken: accessToken, env: env)
            let id = args["id"] as! String
            let before = args["before"] as? String
            let after = args["after"] as? String
            let perPage = args["perPage"] as? Int32
            client.send(BankAPI.User.GetTransactions(id: id, before: before, after: after, perPage: perPage), handler: self.after)
        case "listMessages":
            let env = flutterEnvToSDKEnv(ienv: args["env"] as! Int32)
            let accessToken = args["accessToken"] as! String
            let client = Pokepay.Client(accessToken: accessToken, env: env)
            let before = args["before"] as? String
            let after = args["after"] as? String
            let perPage = args["perPage"] as? Int32
            client.send(MessagingAPI.List(before: before, after: after, perPage: perPage), handler: self.after)
        case "receiveMessageAttachment":
            let env = flutterEnvToSDKEnv(ienv: args["env"] as! Int32)
            let accessToken = args["accessToken"] as! String
            let client = Pokepay.Client(accessToken: accessToken, env: env)
            let id = args["id"] as! String
            client.send(MessagingAPI.ReceiveAttachment(id: id), handler: self.after)
        case "refreshAccessToken":
            let env = flutterEnvToSDKEnv(ienv: args["env"] as! Int32)
            let refreshToken = args["refreshToken"] as! String
            let clientId = args["clientId"] as! String
            let clientSecret = args["clientSecret"] as! String
            let grantType = args["grantType"] as! String
            let client = Pokepay.OAuthClient(clientId: clientId, clientSecret: clientSecret, env: env)
            client.send(OAuthAPI.Token.RefreshAccessToken(refreshToken: refreshToken, clientId: clientId, clientSecret: clientSecret, grantType: grantType), handler: self.after)
        case "registerUserEmail":
            let env = flutterEnvToSDKEnv(ienv: args["env"] as! Int32)
            let accessToken = args["accessToken"] as! String
            let client = Pokepay.Client(accessToken: accessToken, env: env)
            let token = args["token"] as! String
            client.send(BankAPI.User.RegisterEmail(token: token), handler: self.after)
        case "scanToken":
            // FIXME:
            self.result(FlutterMethodNotImplemented)
        case "searchPrivateMoneys":
            let env = flutterEnvToSDKEnv(ienv: args["env"] as! Int32)
            let accessToken = args["accessToken"] as! String
            let client = Pokepay.Client(accessToken: accessToken, env: env)
            let name = args["name"] as? String
            let includeExclusive = args["includeExclusive"] as! Bool
            let before = args["before"] as? String
            let after = args["after"] as? String
            let perPage = args["perPage"] as? Int32
            client.send(BankAPI.PrivateMoney.Search(name: name, includeExclusive: includeExclusive, before: before, after: after, perPage: perPage), handler: self.after)
        case "sendConfirmationEmail": // FIXME: sendUserConfir...
            let env = flutterEnvToSDKEnv(ienv: args["env"] as! Int32)
            let accessToken = args["accessToken"] as! String
            let client = Pokepay.Client(accessToken: accessToken, env: env)
            let id = args["id"] as! String
            let email = args["email"] as! String
            client.send(BankAPI.User.SendConfirmationEmail(id: id, email: email), handler: self.after)
        case "sendMessage":
            let env = flutterEnvToSDKEnv(ienv: args["env"] as! Int32)
            let accessToken = args["accessToken"] as! String
            let client = Pokepay.Client(accessToken: accessToken, env: env)
            let toUserId = args["toUserId"] as! String
            let amount = args["amount"] as? Double
            let subject = args["subject"] as! String
            let body = args["body"] as! String
            let fromAccountId = args["fromAccountId"] as? String
            client.send(MessagingAPI.Send(toUserId: toUserId, amount: amount, subject: subject, body: body, fromAccountId: fromAccountId), handler: self.after)
        case "sendToAccount":
            let env = flutterEnvToSDKEnv(ienv: args["env"] as! Int32)
            let accessToken = args["accessToken"] as! String
            let client = Pokepay.Client(accessToken: accessToken, env: env)
            let accountId = args["accountId"] as! String
            let amount = args["amount"] as! Double
            let receiverTerminalId = args["receiverTerminalId"] as? String
            let senderAccountId = args["senderAccountId"] as? String
            let description = args["description"] as? String
            client.send(BankAPI.Transaction.SendToAccount(accountId: accountId, amount: amount, receiverTerminalId: receiverTerminalId, senderAccountId: senderAccountId, description: description), handler: self.after)
        case "sendToUser":
            let env = flutterEnvToSDKEnv(ienv: args["env"] as! Int32)
            let accessToken = args["accessToken"] as! String
            let client = Pokepay.Client(accessToken: accessToken, env: env)
            let userId = args["userId"] as! String
            let amount = args["amount"] as! Double
            let receiverTerminalId = args["receiverTerminalId"] as? String
            let senderAccountId = args["senderAccountId"] as? String
            let description = args["description"] as? String
            client.send(BankAPI.Transaction.SendToUser(userId: userId, amount: amount, receiverTerminalId: receiverTerminalId, senderAccountId: senderAccountId, description: description), handler: self.after)
        case "updateBill":
            let env = flutterEnvToSDKEnv(ienv: args["env"] as! Int32)
            let accessToken = args["accessToken"] as! String
            let client = Pokepay.Client(accessToken: accessToken, env: env)
            let id = args["id"] as! String
            let amount = args["amount"] as? Double
            let description = args["description"] as? String
            client.send(BankAPI.Bill.Update(id: id, amount: amount, description: description), handler: self.after)
        case "updateCashtray":
            let env = flutterEnvToSDKEnv(ienv: args["env"] as! Int32)
            let accessToken = args["accessToken"] as! String
            let client = Pokepay.Client(accessToken: accessToken, env: env)
            let id = args["id"] as! String
            let amount = args["amount"] as? Double
            let description = args["description"] as? String
            let expiresIn = args["expiresIn"] as? Int32
            client.send(BankAPI.Cashtray.Update(id: id, amount: amount, description: description, expiresIn: expiresIn), handler: self.after)
        case "updateCheck":
            let env = flutterEnvToSDKEnv(ienv: args["env"] as! Int32)
            let accessToken = args["accessToken"] as! String
            let client = Pokepay.Client(accessToken: accessToken, env: env)
            let id = args["id"] as! String
            let amount = args["amount"] as? Double
            let description = args["description"] as? String
            let expiresAt = stringToDate(s: (args["expiresAt"] as? String))
            let pointExpiresAt = stringToDate(s: (args["pointExpiresAt"] as? String))
            let pointExpiresInDays = args["pointExpiresInDays"] as? Int32
            client.send(BankAPI.Check.Update(id: id, amount: amount, description: description, expiresAt: expiresAt, pointExpiresAt: pointExpiresAt, pointExpiresInDays: pointExpiresInDays), handler: self.after)
        case "updateTerminal":
            let env = flutterEnvToSDKEnv(ienv: args["env"] as! Int32)
            let accessToken = args["accessToken"] as! String
            let client = Pokepay.Client(accessToken: accessToken, env: env)
            let name = args["name"] as! String
            let accountId = args["accountId"] as! String
            let pushToken = args["pushToken"] as? String
            client.send(BankAPI.Terminal.Update(name: name, accountId: accountId, pushToken: pushToken), handler: self.after)
        case "updateUser":
            let env = flutterEnvToSDKEnv(ienv: args["env"] as! Int32)
            let accessToken = args["accessToken"] as! String
            let client = Pokepay.Client(accessToken: accessToken, env: env)
            let id = args["id"] as! String
            let name = args["name"] as? String
            client.send(BankAPI.User.Update(id: id, name: name), handler: self.after)
        default:
            self.result(FlutterMethodNotImplemented)
        }
    }
}

public class SwiftPokepaySdkPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "jp.pokepay/pokepay_sdk", binaryMessenger: registrar.messenger())
    let instance = SwiftPokepaySdkPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    let method = MethodCallTask(c: call, r: result)
    method.invokeMethod()
  }
}
