public extension String {
    /// [CHUtils] Creates a string of value `""`.
    static var empty: Self {
        return ""
    }

    /// [CHUtils] Creates a string composed of purely whitespaces with a given length.
    /// - Parameter n: length of whitespaces.
    ///
    /// - Returns: a string composed of purely whitespaces with a given length. In cases where a negative `n` is passed, this function returns `""`.
    static func whitespaces(n: Int = 1) -> Self {
        guard n >= 0 else {
            return ""
        }
        return [String](repeating: " ", count: n).joined()
    }
}
