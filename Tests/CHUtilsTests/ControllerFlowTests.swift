import XCTest
import CHUtils

// MARK: - UIKit
#if canImport(UIKit)
import UIKit

final class UIControllerFlowTests: XCTestCase {
    func testInit() {
        let flow = ControllerFlow()
        flow.launch(from: UIViewController())
    }

    func testLaunch() {
        let spy = ControllerFlowSpy()
        let stub = ViewControllerStub()
        spy.launch(from: stub)
        XCTAssertEqual(stub.count, 1)
    }
}

private final class ViewControllerStub: UIViewController {
    var count = Int.zero
}
#endif

// MARK: - Cocoa
#if canImport(Cocoa)
import Cocoa

final class NSControllerFlowTests: XCTestCase {
    func testInit() {
        let flow = ControllerFlow()
        flow.launch(from: NSViewController())
    }

    func testLaunch() {
        let spy = ControllerFlowSpy()
        let stub = ViewControllerStub()
        spy.launch(from: stub)
        XCTAssertEqual(stub.count, 1)
    }
}

private final class ViewControllerStub: NSViewController {
    var count = Int.zero
}
#endif

private final class ControllerFlowSpy: ControllerFlow {
    override func launch(from current: ControllerFlow.Context) {
        let stub = current as! ViewControllerStub
        stub.count += 1
    }
}
