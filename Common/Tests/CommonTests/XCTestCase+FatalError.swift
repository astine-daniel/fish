@testable import Common

import XCTest

extension XCTestCase {
    func expectFatalError(expectedMessage: String, testCase: @escaping () -> Void) {
        let expectation = self.expectation(description: "expectingFatalError")
        var assertionMessage: String?

        FatalError.replace { message, _, _ in
            assertionMessage = message()
            expectation.fulfill()
            self.unreachable()
        }

        DispatchQueue.global(qos: .userInitiated)
            .async(execute: testCase)

        waitForExpectations(timeout: 2.0) { _ in
            XCTAssertEqual(assertionMessage, expectedMessage)
            FatalError.restore()
        }
    }
}

private extension XCTestCase {
    func unreachable() -> Never {
        repeat {
            RunLoop.current.run()
        } while true
    }
}
