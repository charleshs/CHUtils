/**
 An abstraction layer for the navigation in GUI applications.
 */
public protocol Flow {

    associatedtype Context

    /// Launches this flow from the current context.
    func launch(from current: Context)
}
