import XCTest
import CHUtils

final class StringExtensionsTests: XCTestCase {
    func testEmpty() {
        XCTAssertEqual(String.empty, "")
    }

    func testSpaces() {
        XCTAssertEqual(String.whitespaces(), " ")
        XCTAssertEqual(String.whitespaces(n: 0), "")
        XCTAssertEqual(String.whitespaces(n: 5), "     ")
        XCTAssertEqual(String.whitespaces(n: Int.min), "")
    }
}
