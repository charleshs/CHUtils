public final class PersistenceSubscription {
    private let onCancelled: () -> Void

    init(onCancelled: @escaping () -> Void) {
        self.onCancelled = onCancelled
    }

    deinit {
        onCancelled()
    }

    public func unregister() {
        onCancelled()
    }
}
