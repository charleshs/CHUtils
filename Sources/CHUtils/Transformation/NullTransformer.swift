public struct NullTransformer<T, U>: Transformable {
    /// The Singleton that represents a null transformer
    public static var `default`: Self? { return nil }

    private init() {}

    public func reverse(from object: U) throws -> T { fatalError() }

    public func transform(_ substrate: T) throws -> U { fatalError() }
}
