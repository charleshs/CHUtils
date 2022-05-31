import XCTest

#if canImport(UIKit)
import UIKit
import CHUtils

final class ControllerFlowFactoryTests: XCTestCase {
    enum Action: Hashable {
        case exit
        case proceed
    }

    private class ControllerFlowFactorySpy: ControllerFlowFactory<Action> {
        private var requestCounts: [Action: Int] = [:]

        override func controllerFlow(for action: ControllerFlowFactoryTests.Action) -> ControllerFlow {
            requestCounts[action, default: 0] += 1
            return super.controllerFlow(for: action)
        }

        func count(for action: Action) -> Int {
            return requestCounts[action, default: 0]
        }
    }

    func testInit() {
        let factory = ControllerFlowFactorySpy()
        _ = factory.controllerFlow(for: .exit)
        _ = factory.controllerFlow(for: .proceed)
        _ = factory.controllerFlow(for: .exit)

        XCTAssertEqual(factory.count(for: .exit), 2)
        XCTAssertEqual(factory.count(for: .proceed), 1)
    }
}

#endif
