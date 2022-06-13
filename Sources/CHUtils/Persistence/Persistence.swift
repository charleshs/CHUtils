import Foundation

public protocol Persistence {
    associatedtype Key: Hashable

    /// [CHUtils] Loads the value (if exists) with an associated key.
    /// - Parameters:
    ///   - withType: type of the value.
    ///   - key: the associated key.
    ///   - transformer: a transformer that converts loaded chunk of data into `Value`.
    /// - Returns: the persisted value with associated key.
    func loadValue<Value, DataTransform: Transformable>(withType: Value.Type,
                                                        forKey key: Key,
                                                        transformer: DataTransform?) -> Value?
    where DataTransform.Product == Data, DataTransform.Substrate == Value

    /// [CHUtils] Saves the value and associates it with a specific key.
    /// - Parameters:
    ///   - value: the value to be stored.
    ///   - key: the associated key.
    ///   - transformer: a transformer that converts `value` into data representation for persistence.
    func saveValue<Value, DataTransform: Transformable>(_ value: Value,
                                                        forKey key: Key,
                                                        transformer: DataTransform?)
    where DataTransform.Product == Data, DataTransform.Substrate == Value

    /// [CHUtils] Removes any value associated with a specific key.
    /// - Parameter key: the associated key.
    func removeValue(forKey key: Key)
}
