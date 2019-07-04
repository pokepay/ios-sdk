import XCTest
import APIKit
@testable import Pokepay

final class PokepayTests: XCTestCase {
    func testGetTerminal() {
        let expect = expectation(description: "get request test")
        let client = Pokepay.Client(accessToken: "ZhwMsfoAyWZMGrCAKrrofmwYHV82GkUcf3kYSZYYf1oDKVvFAPIKuefyQoc1KDVr",
                                    env: .development)
        client.getTerminalInfo() { result in
            switch result {
            case .success(let response):
                print(response)
                expect.fulfill()
            case .failure:
                print(result)
                expect.fulfill()
            }
        }
        waitForExpectations(timeout: 5.0, handler: nil)
    }

    func testAddPublicKey() {
        let expect = expectation(description: "add public key request test")
        let client = Pokepay.Client(accessToken: "ZhwMsfoAyWZMGrCAKrrofmwYHV82GkUcf3kYSZYYf1oDKVvFAPIKuefyQoc1KDVr",
                                    env: .development)
        client.send(BankAPI.Terminal.AddPublicKey(key:
"""
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAq8oHIShTIJHrQpBQqAVs
JxjhstGMghotRq2QaU0PU7y4jR42AAWMHzjzTxQUjE/Id/ko5lwbFx+tco0NvJVR
vPulU82D0pMlfc0oXd2dJ+UWvw7Fpg0+lo2o4R7fMQxt91fKfktyOkga1rUJ3SDH
601jw43ptdAPgugMloD9uExkbNqXXKjzruksDssh7mvIIe33Yz/463VrcSOaLgBA
OSj+GhSx4PuQz8yUk/Jo0ebaaBPtf0imVkhsp8v4v8LvXhrqRy+k6V58gW4nJvu+
rUfw+waqKu5AJycsUD6C1zbaj7mTXUTRNyZegDJHV8wRuSa4kFSB5S5KIGflM9M4
AQIDAQAB
""")) { result in
            switch result {
            case .success(let response):
                print(response)
                expect.fulfill()
            case .failure(.responseError(let error as BankAPIError)):
                print("responseError")
                switch error {
                case .clientError(let code, let apiError):
                    print("code: \(code)")
                    print("type: \(apiError.type)")
                    print("message: \(apiError.message)")
                default:
                    print("other error")
                }
                expect.fulfill()
            case .failure:
                print(result)
                expect.fulfill()
            }
        }
        waitForExpectations(timeout: 5.0, handler: nil)
    }

    func testCreateToken() {
        let expect = expectation(description: "create token test")
        let client = Pokepay.Client(accessToken: "ZhwMsfoAyWZMGrCAKrrofmwYHV82GkUcf3kYSZYYf1oDKVvFAPIKuefyQoc1KDVr",
                                    isMerchant: true,
                                    env: .development)
        client.createToken(108) { result in
            switch result {
            case .success(let token):
                print(token)
                expect.fulfill()
            case .failure(let error):
                print(error)
                expect.fulfill()
            }
        }
        waitForExpectations(timeout: 5.0, handler: nil)
    }

    func testClientGetTerminal() {
        let expect = expectation(description: "client.getTerminal")
        let client = Pokepay.Client(accessToken: "ZhwMsfoAyWZMGrCAKrrofmwYHV82GkUcf3kYSZYYf1oDKVvFAPIKuefyQoc1KDVr",
                                    isMerchant: true,
                                    env: .development)
        client.getTerminalInfo() { result in
            switch result {
            case .success(let terminal):
                print(terminal)
                expect.fulfill()
            case .failure(let error):
                print(error)
                expect.fulfill()
            }
        }
        waitForExpectations(timeout: 5.0, handler: nil)
    }

    func testGetTokenInfo() {
        let expect = expectation(description: "client.getTokenInfo")
        let client = Pokepay.Client(accessToken: "ZhwMsfoAyWZMGrCAKrrofmwYHV82GkUcf3kYSZYYf1oDKVvFAPIKuefyQoc1KDVr",
                                    isMerchant: false,
                                    env: .development)
        let dispatchGroup = DispatchGroup()
        // check
        dispatchGroup.enter()
        client.createToken(108) { result in
            switch result {
            case .success(let token):
                print(token)
                let client2 = Pokepay.Client(accessToken: "x7wPPW4QQ1wvu93LlP8GSgCIdG2Pic7anH3UO9kdRZPYDs6ym0V_y40TW6iVc-rY",
                                             env: .development)
                client2.getTokenInfo(token) { result in
                    switch result {
                    case .success(let value):
                        switch value {
                        case .check(_):
                            dispatchGroup.leave()
                        default:
                            print(value)
                            XCTFail("Unexpected type")
                        }
                    case .failure(let error):
                        print(error)
                        XCTFail("Error on getTokenInfo")
                    }
                }
            case .failure(let error):
                print(error)
                XCTFail("Error on createToken")
            }
        }

        // bill
        dispatchGroup.enter()
        client.createToken(-108) { result in
            switch result {
            case .success(let token):
                print(token)
                let client2 = Pokepay.Client(accessToken: "x7wPPW4QQ1wvu93LlP8GSgCIdG2Pic7anH3UO9kdRZPYDs6ym0V_y40TW6iVc-rY",
                                             env: .development)
                client2.getTokenInfo(token) { result in
                    switch result {
                    case .success(let value):
                        switch value {
                        case .bill(_):
                            dispatchGroup.leave()
                        default:
                            print(value)
                            XCTFail("Unexpected type")
                        }
                    case .failure(let error):
                        print(error)
                        XCTFail("Error on getTokenInfo")
                    }
                }
            case .failure(let error):
                print(error)
                XCTFail("Error on createToken")
            }
        }

        let mclient = Pokepay.Client(accessToken: "ZhwMsfoAyWZMGrCAKrrofmwYHV82GkUcf3kYSZYYf1oDKVvFAPIKuefyQoc1KDVr",
                                    isMerchant: true,
                                    env: .development)
        // cashtray
        dispatchGroup.enter()
        mclient.createToken(108) { result in
            switch result {
            case .success(let token):
                print(token)
                let client2 = Pokepay.Client(accessToken: "x7wPPW4QQ1wvu93LlP8GSgCIdG2Pic7anH3UO9kdRZPYDs6ym0V_y40TW6iVc-rY",
                                             env: .development)
                client2.getTokenInfo(token) { result in
                    switch result {
                    case .success(let value):
                        switch value {
                        case .cashtray(_):
                            dispatchGroup.leave()
                        default:
                            print(value)
                            XCTFail("Unexpected type")
                        }
                    case .failure(let error):
                        print(error)
                        XCTFail("Error on getTokenInfo")
                    }
                }
            case .failure(let error):
                print(error)
                XCTFail("Error on createToken")
            }
        }

        dispatchGroup.notify(queue: DispatchQueue.main, work: DispatchWorkItem(block: {
            expect.fulfill()
        }))
        
        waitForExpectations(timeout: 5.0, handler: nil)
    }

    func testScanToken() {
        let expect = expectation(description: "client.scanToken")
        let client = Pokepay.Client(accessToken: "ZhwMsfoAyWZMGrCAKrrofmwYHV82GkUcf3kYSZYYf1oDKVvFAPIKuefyQoc1KDVr",
                                    isMerchant: true,
                                    env: .development)
        client.createToken(108) { result in
            switch result {
            case .success(let token):
                print(token)
                let client2 = Pokepay.Client(accessToken: "x7wPPW4QQ1wvu93LlP8GSgCIdG2Pic7anH3UO9kdRZPYDs6ym0V_y40TW6iVc-rY",
                                             env: .development)
                client2.scanToken(token) { result in
                    switch result {
                    case .success(let transaction):
                        print(transaction)
                        expect.fulfill()
                    case .failure(let error):
                        print(error)
                        expect.fulfill()
                    }
                }
            case .failure(let error):
                print(error)
                expect.fulfill()
            }
        }
        waitForExpectations(timeout: 5.0, handler: nil)
    }

    func testAuthorizationUrl() {
        let expect = expectation(description: "OAuthClient.getAuthorizationUrl")
        let oauth = Pokepay.OAuthClient(clientId: "3qyJZlDnJbGK5roa-5XLkw", clientSecret: "kz96I8SDmjl2x77aAI9iNvAjc0cneL3UoK6zKLjmdXwmoghC7FSRrqKr")
        print(oauth.getAuthorizationUrl())
        expect.fulfill()
        waitForExpectations(timeout: 5.0, handler: nil)
    }

    func testGetAccessToken() {
        let expect = expectation(description: "OAuthClient.getAccessToken")
        let oauth = Pokepay.OAuthClient(clientId: "3qyJZlDnJbGK5roa-5XLkw", clientSecret: "kz96I8SDmjl2x77aAI9iNvAjc0cneL3UoK6zKLjmdXwmoghC7FSRrqKr")
        oauth.getAccessToken(code: "NdnqscefbW4RVa30/DvOf1vKDuPaX0e4") { result in
            switch result {
            case .success(let response):
                print(response)
                expect.fulfill()
            case .failure:
                print(result)
                expect.fulfill()
            }
        }
        waitForExpectations(timeout: 5.0, handler: nil)
    }

    func testSearchPrivateMoney() {
        let expect = expectation(description: "SearchPrivateMoney")
        let client = Pokepay.Client(accessToken: "ZhwMsfoAyWZMGrCAKrrofmwYHV82GkUcf3kYSZYYf1oDKVvFAPIKuefyQoc1KDVr",
                                    isMerchant: true,
                                    env: .development)
        client.send(BankAPI.PrivateMoney.Search()) { result in
            switch result {
            case .success(let response):
                print(response)
                expect.fulfill()
            case .failure:
                print(result)
                expect.fulfill()
            }
        }
        waitForExpectations(timeout: 5.0, handler: nil)
    }

    func testListMessages() {
        let expect = expectation(description: "ListMessages")
        let client = Pokepay.Client(accessToken: "4evQMOwx077ev_ke6f1-E1TxQvs5B1KZh9uwscJbncblfw0Hrcta_L2Fs4Nlyc0s",
                                    env: .development)
        client.send(MessagingAPI.List()) { result in
            switch result {
            case .success(let response):
                print(response)
                expect.fulfill()
            case .failure:
                print(result)
                expect.fulfill()
            }
        }
        waitForExpectations(timeout: 5.0, handler: nil)
    }

    func testCpmTokens() {
        var expect = expectation(description: "404 should return when get random CPM token.")
        let customer = Pokepay.Client(accessToken: "oNTvWHFqv512JJQhUVgAwCx7LphHVpHFAp_jDMQ62THIN9iOwNfUXA9nMkI66xoA", env: .development)
        let merchant = Pokepay.Client(accessToken: "7mL_asUSVHUZhW11nDJzlm-Xa7-01VjgVBPi8Hd43UAqYpMCEfEuzLPGWfKr0VU9", env: .development)
        customer.send(BankAPI.CpmToken.Get(cpmToken: "000011112222")) { result in
            switch result {
            case .success:
                XCTFail("This call should be 404.")
            case .failure(.responseError(let error as BankAPIError)):
                switch error {
                case .clientError(let code, let apiError):
                    print("code: \(code)")
                    print("type: \(apiError.type)")
                    print("message: \(apiError.message)")
                    if code != 404 {
                        XCTFail("This call shold be 404.")
                    } else {
                        expect.fulfill()
                    }
                default:
                    XCTFail("unknown error")
                }
            case .failure:
                XCTFail("unknown error")
            }
        }
        waitForExpectations(timeout: 5.0, handler: nil)
        // ---
        expect = expectation(description: "Create CPM with customer AccessToken")
        customer.send(BankAPI.Account.CreateAccountCpmToken(accountId: "d360738a-55e4-469b-882f-c866dc21e5d8", scopes: BankAPI.Account.CreateAccountCpmToken.Scope.BOTH, expiresIn: 100)) { result in
            switch result {
            case .success(let response):
                let token = response.cpmToken
                customer.send(BankAPI.CpmToken.Get(cpmToken: token)) { result in
                    switch result {
                    case .success(let response):
                        if response.transaction != nil {
                            XCTFail("transaction should be null")
                        }
                        let balanceBefore = response.account.balance
                        merchant.send(BankAPI.Transaction.CreateWithCpm(cpmToken: token, amount: 1000.0)) { result in
                            switch result {
                            case .success:
                                customer.send(BankAPI.CpmToken.Get(cpmToken: token)) { result in
                                    switch result {
                                    case .success(let response):
                                        if response.transaction == nil {
                                            XCTFail("transaction should be")
                                        }
                                        let balanceAfter = response.account.balance
                                        if balanceBefore + 1000.0 != balanceAfter {
                                            XCTFail("balance not match")
                                        }
                                        expect.fulfill()
                                    case .failure(let err):
                                        print(err)
                                        XCTFail()
                                    }
                                }
                            case .failure(let err):
                                print(err)
                                XCTFail()
                            }
                        }
                    case .failure(let err):
                        print(err)
                        XCTFail()
                    }
                }
            case .failure(let err):
                print(err)
                XCTFail()
            }
        }
        waitForExpectations(timeout: 5.0, handler: nil)
     }

    static var allTests = [
      ("testGetTerminal", testGetTerminal),
      ("testAddPublicKey", testAddPublicKey),
      ("testCreateToken", testCreateToken),
      ("testClientGetTerminal", testClientGetTerminal),
      ("testGetTokenInfo", testGetTokenInfo),
      ("testScanToken", testScanToken),
      ("testAuthorizationUrl", testAuthorizationUrl),
      ("testGetAccessToken", testGetAccessToken),
      ("testSearchPrivateMoney", testSearchPrivateMoney),
      ("testListMessages", testListMessages),
      ("testCpmTokens", testCpmTokens),
    ]
}
