import Foundation

public struct UserDefaultsWrapper: Persistence {
    let userDefaults: UserDefaults

    public init(_ userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
    }

    public func loadValue<Value, DataTransform>(withType: Value.Type, forKey key: String, transformer: DataTransform?) -> Value?
    where DataTransform: Transformable, DataTransform.Product == Data, DataTransform.Substrate == Value
    {
        guard let transformer = transformer else {
            return userDefaults.object(forKey: key) as? Value
        }
        guard let data = userDefaults.data(forKey: key) else {
            return nil
        }

        do {
            return try transformer.reverse(from: data)
        } catch {
            assertionFailure("Failed in loading value with transformer \(transformer)")
            return nil
        }
    }

    public func saveValue<Value, DataTransform>(_ value: Value, forKey key: String, transformer: DataTransform?)
    where DataTransform: Transformable, DataTransform.Product == Data, DataTransform.Substrate == Value
    {
        guard let transformer = transformer else {
            userDefaults.set(value, forKey: key)
            return
        }

        guard let data = try? transformer.transform(value) else {
            assertionFailure("Failed to transform \(value) into data representation.")
            return
        }

        userDefaults.set(data, forKey: key)
    }

    public func removeValue(forKey key: String) {
        userDefaults.removeObject(forKey: key)
    }
}
