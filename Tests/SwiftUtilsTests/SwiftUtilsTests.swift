import XCTest
@testable import SwiftUtils

class SwiftUtilsTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(SwiftUtils().text, "Hello, World!")
    }


    static var allTests : [(String, (SwiftUtilsTests) -> () throws -> Void)] {
        return [
            ("testExample", testExample),
        ]
    }
}
