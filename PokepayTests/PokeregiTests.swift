import XCTest
import APIKit
@testable import Pokepay

final class PokeregiTests: XCTestCase {

    func testCypherAES() {
        let plain = "abcdefghijklmnopqrstuvwxyz"
        let key = "0123456789ABCDEF"
        let iv = "FEDCBA9876543210"
        let encrypted = try! Cypher.AES.encrypt(plainString: plain, sharedKey: key, iv: iv)
        let plain2 = try! Cypher.AES.decrypt(encryptedData: encrypted, sharedKey: key, iv: iv)
        XCTAssertEqual(plain, plain2)
    }

    func testScanToken() {
        let expect = expectation(description: "client.scanToken")
        let client = Pokepay.Client(accessToken: "ZhwMsfoAyWZMGrCAKrrofmwYHV82GkUcf3kYSZYYf1oDKVvFAPIKuefyQoc1KDVr",
                                    isMerchant: true,
                                    env: .development)
        client.scanToken("E2628QWXKAIVZ03W1Q84C4RB5") { result in
            switch result {
            case .success(let transaction):
                print(transaction)
                expect.fulfill()
            case .failure(let error):
                print(error)
                expect.fulfill()
            }
        }
        waitForExpectations(timeout: 5.0, handler: nil)
    }

    static var allTests = [
        ("testCypherAES", testCypherAES),
        ("testScanToken", testScanToken),
    ]
}
