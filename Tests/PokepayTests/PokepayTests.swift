import XCTest
import APIKit
@testable import Pokepay

final class PokepayTests: XCTestCase {
    func testGetTerminal() {
        let expect = expectation(description: "get request test")
        Session.send(GetTerminalRequest()) { result in
            switch result {
            case .success(let response):
                print(response)
                expect.fulfill()
            case .failure:
                print(result)
                break
            }
        }
        waitForExpectations(timeout: 5.0, handler: nil)
    }


    static var allTests = [
        ("testGetTerminal", testGetTerminal),
    ]
}
