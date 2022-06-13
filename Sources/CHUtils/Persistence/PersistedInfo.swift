import Foundation

@propertyWrapper
public struct PersistedInfo<Value, Storage: Persistence, DataTransform: Transformable> where Storage.Key == String, DataTransform.Product == Data, DataTransform.Substrate == Value {
    public var wrappedValue: Value? {
        get {
            persistence.loadValue(withType: Value.self, forKey: key, transformer: dataTransform)
        }
        set {
            let oldValue = wrappedValue

            if let newValue = newValue {
                persistence.saveValue(newValue, forKey: key, transformer: dataTransform)
                projectedValue.notifyListeners(newValue: newValue, oldValue: oldValue)
            } else {
                persistence.removeValue(forKey: key)
                projectedValue.notifyListeners(newValue: nil, oldValue: oldValue)
            }
        }
    }

    public let projectedValue: PersistenceSubscribers = PersistenceSubscribers<Optional<Value>>()

    private let key: Storage.Key
    private let persistence: Storage
    private let dataTransform: DataTransform?

    public init(key: Storage.Key, persistence: Storage, dataTransform: DataTransform?) {
        self.persistence = persistence
        self.key = key
        self.dataTransform = dataTransform
    }
}
