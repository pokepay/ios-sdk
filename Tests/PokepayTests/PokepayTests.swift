import XCTest
import APIKit
@testable import Pokepay

final class PokepayTests: XCTestCase {
    func testGetTerminal() {
        let expect = expectation(description: "get request test")
        let client = Pokepay.Client(accessToken: "ZhwMsfoAyWZMGrCAKrrofmwYHV82GkUcf3kYSZYYf1oDKVvFAPIKuefyQoc1KDVr")
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
        let client = Pokepay.Client(accessToken: "ZhwMsfoAyWZMGrCAKrrofmwYHV82GkUcf3kYSZYYf1oDKVvFAPIKuefyQoc1KDVr")
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
                                    isMerchant: true)
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
                                    isMerchant: true)
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

    func testScanToken() {
        let expect = expectation(description: "client.scanToken")
        let client = Pokepay.Client(accessToken: "ZhwMsfoAyWZMGrCAKrrofmwYHV82GkUcf3kYSZYYf1oDKVvFAPIKuefyQoc1KDVr",
                                    isMerchant: true)
        client.createToken(108) { result in
            switch result {
            case .success(let token):
                print(token)
                let client2 = Pokepay.Client(accessToken: "lR5iX_U7TB7o_-FBCO5LpW6t7x-UQ4w3HpdqnZ8QoS1GlQM09n-swfQqbZQMqbvc")
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

    static var allTests = [
      ("testGetTerminal", testGetTerminal),
      ("testAddPublicKey", testAddPublicKey),
      ("testCreateToken", testCreateToken),
      ("testClientGetTerminal", testClientGetTerminal),
      ("testScanToken", testScanToken),
      ("testAuthorizationUrl", testAuthorizationUrl),
      ("testGetAccessToken", testGetAccessToken),
    ]
}
