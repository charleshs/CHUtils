import Foundation

@propertyWrapper
public struct PersistedInfo<Value, Storage: Persistence, DataTransform: Transformable> where Storage.Key == String, DataTransform.Product == Data, DataTransform.Substrate == Value {
    public var wrappedValue: Value? {
        get {
            persistence.loadValue(withType: Value.self, forKey: key, transformer: dataTransform)
        }
        set {
            if let newValue = newValue {
                persistence.saveValue(newValue, forKey: key, transformer: dataTransform)
            } else {
                persistence.removeValue(forKey: key)
            }
        }
    }

    private let key: Storage.Key
    private let persistence: Storage
    private let dataTransform: DataTransform?

    public init(key: Storage.Key, persistence: Storage, dataTransform: DataTransform?) {
        self.persistence = persistence
        self.key = key
        self.dataTransform = dataTransform
    }
}
