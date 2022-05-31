#if canImport(UIKit)
import UIKit

extension Flow where Context: UIViewController {
    public func push(
        destination: Context,
        source: Context,
        animated: Bool
    ) {
        guard let navigationController = source.navigationController else {
            debugCritical("Context \(source) is not embedded in a navigation controller.")
            return
        }
        navigationController.pushViewController(destination, animated: animated)
    }

    public func present(
        destination: Context,
        presenter: Context,
        animated: Bool,
        completion: (() -> Void)? = nil,
        presentationStyle: UIModalPresentationStyle? = nil,
        transitionStyle: UIModalTransitionStyle? = nil
    ) {
        if let presentationStyle = presentationStyle {
            destination.modalPresentationStyle = presentationStyle
        }
        if let transitionStyle = transitionStyle {
            destination.modalTransitionStyle = transitionStyle
        }
        presenter.present(destination, animated: animated, completion: completion)
    }
}

open class PushFlow: ControllerFlow {
    public var destination: ViewController
    public var animated: Bool

    public init(
        destination: ViewController,
        animated: Bool = true
    ) {
        self.destination = destination
        self.animated = animated
    }

    open override func launch(from current: ViewController) {
        push(destination: destination, source: current, animated: animated)
    }
}

open class PresentFlow: ControllerFlow {
    public var destination: UIViewController
    public var animated: Bool
    public var completion: (() -> Void)?
    public var presentationStyle: UIModalPresentationStyle?
    public var transitionStyle: UIModalTransitionStyle?

    public init(
        destination: UIViewController,
        animated: Bool = true,
        completion: (() -> Void)? = nil,
        presentationStyle: UIModalPresentationStyle? = nil,
        transitionStyle: UIModalTransitionStyle? = nil
    ) {
        self.destination = destination
        self.animated = animated
        self.completion = completion
        self.presentationStyle = presentationStyle
        self.transitionStyle = transitionStyle
    }

    open override func launch(from current: UIViewController) {
        present(
            destination: destination,
            presenter: current,
            animated: animated,
            completion: completion,
            presentationStyle: presentationStyle,
            transitionStyle: transitionStyle
        )
    }
}
#endif
