import Foundation

public struct CodableJSONTransformer<T: Codable>: Transformable {
    public let encoder: JSONEncoder
    public let decoder: JSONDecoder

    public init(encoder: JSONEncoder = .init(), decoder: JSONDecoder = .init()) {
        self.encoder = encoder
        self.decoder = decoder
    }

    public func transform(_ object: T) throws -> Data {
        return try encoder.encode(object)
    }

    public func reverse(from data: Data) throws -> T {
        return try decoder.decode(T.self, from: data)
    }
}
