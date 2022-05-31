public protocol ControllerFlowFactoryType {
    associatedtype ActionType

    func controllerFlow(for action: ActionType) -> ControllerFlow
}

open class ControllerFlowFactory<ActionType>: ControllerFlowFactoryType {
    public init() {}

    open func controllerFlow(for action: ActionType) -> ControllerFlow {
        return ControllerFlow()
    }
}
