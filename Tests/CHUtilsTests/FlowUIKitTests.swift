#if canImport(UIKit)
import UIKit
import XCTest
import CHUtils

final class FlowUIKitTests: XCTestCase {
    func testPushFlow() {
        let rootVC = UIViewController()
        let navVC = UINavigationController(rootViewController: rootVC)

        let newVC = UIViewController()
        let pushFlow = PushFlow(destination: newVC, animated: false)

        pushFlow.launch(from: rootVC)

        XCTAssertEqual(navVC.viewControllers.count, 2)
        XCTAssertEqual(navVC.topViewController, newVC)
    }

    func testPresentFlow() {
        let presenter = UIViewController()
        let window = UIWindow()
        window.rootViewController = presenter
        window.makeKeyAndVisible()

        let newVC = UIViewController()
        let presentFlow = PresentFlow(destination: newVC, animated: false, presentationStyle: .formSheet, transitionStyle: .crossDissolve)

        presentFlow.launch(from: presenter)

        XCTAssertEqual(newVC.presentingViewController, presenter)
        XCTAssertEqual(newVC.modalPresentationStyle, .formSheet)
        XCTAssertEqual(newVC.modalTransitionStyle, .crossDissolve)
    }
}
#endif
