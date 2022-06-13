import Foundation

@propertyWrapper
public struct PersistedPref<Value, Storage: Persistence, DataTransform: Transformable> where Storage.Key == String, DataTransform.Product == Data, DataTransform.Substrate == Value {
    public var wrappedValue: Value {
        get {
            persistence.loadValue(withType: Value.self, forKey: key, transformer: dataTransform) ?? defaultValue
        }
        set {
            persistence.saveValue(newValue, forKey: key, transformer: dataTransform)
        }
    }

    private let key: Storage.Key
    private let defaultValue: Value
    private let persistence: Storage
    private let dataTransform: DataTransform?

    public init(key: Storage.Key, defaultValue: Value, persistence: Storage, dataTransform: DataTransform?) {
        self.key = key
        self.defaultValue = defaultValue
        self.persistence = persistence
        self.dataTransform = dataTransform
    }
}
