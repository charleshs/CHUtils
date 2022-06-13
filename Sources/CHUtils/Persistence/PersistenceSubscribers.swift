import Foundation

public final class PersistenceSubscribers<Value> {
    public typealias ListenerAction = (Value, _ old: Value) -> Void

    private(set) var listeners: [(UUID, ListenerAction)] = []

    public func addListener(onChanged: @escaping ListenerAction) -> PersistenceSubscription {
        let uuid = UUID()
        listeners.append((uuid, onChanged))

        return PersistenceSubscription { [weak self] in
            self?.listeners.removeAll(where: { $0.0 == uuid })
        }
    }

    func notifyListeners(newValue: Value, oldValue: Value) {
        listeners.map(\.1).forEach { action in
            action(newValue, oldValue)
        }
    }
}
