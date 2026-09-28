import XCTest
import APIKit
@testable import Pokepay

final class VeritransClientTests: XCTestCase {
    private func configuration(of session: Session) -> URLSessionConfiguration? {
        return (session.adapter as? URLSessionAdapter)?.urlSession.configuration
    }

    func testVeritransSessionDoesNotCache() {
        let configuration = self.configuration(of: Pokepay.VeritransClient.session)
        XCTAssertNotNil(configuration)
        XCTAssertNil(configuration?.urlCache)
    }

    func testSharedSessionKeepsCache() {
        XCTAssertNotNil(configuration(of: Session.shared)?.urlCache)
    }
}
