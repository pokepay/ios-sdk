import XCTest
@testable import Pokepay

final class PokepayTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Pokepay().text, "Hello, World!")
    }


    static var allTests = [
        ("testExample", testExample),
    ]
}
