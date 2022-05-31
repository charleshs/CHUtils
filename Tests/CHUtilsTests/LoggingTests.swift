import XCTest
@testable import CHUtils

final class LoggingTests: XCTestCase {
    func testInOneGo() {
        debugInfo(#function)
        debugWarning(#function)
        debugCritical(#function)
    }
}
