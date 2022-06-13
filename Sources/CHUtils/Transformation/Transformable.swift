public protocol Transformable {
    associatedtype Substrate
    associatedtype Product

    func transform(_ substrate: Substrate) throws -> Product

    func reverse(from object: Product) throws -> Substrate
}
