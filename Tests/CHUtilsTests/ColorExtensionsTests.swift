import XCTest
import CHUtils

// MARK: - UIKit
#if canImport(UIKit)
import UIKit

final class UIColorExtensionsTests: XCTestCase {
    func testGetRandomUIColor() {
        _ = UIColor.getRandom()
    }
}
#endif

// MARK: - Cocoa
#if canImport(Cocoa)
import Cocoa

final class NSColorExtensionsTests: XCTestCase {
    func testGetRandomNSColor() {
        _ = NSColor.getRandom()
    }
}
#endif
