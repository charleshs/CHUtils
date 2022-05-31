#if canImport(UIKit)
import UIKit
public typealias ViewController = UIViewController
#else
import Cocoa
public typealias ViewController = NSViewController
#endif

open class ControllerFlow: Flow {
    public typealias Context = ViewController

    public init() {}

    #if DEBUG
    deinit {
        debugInfo("Deallocating: \(self)")
    }
    #endif

    open func launch(from current: Context) {}
}
