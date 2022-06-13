public extension Collection {
    /// [CHUtils] Returns the element (if exists) at a given index.
    /// `Nil` is return when the index is valid.
    subscript(at index: Index) -> Element? {
        guard indices.contains(index) else {
            return nil
        }
        return self[index]
    }
}

public extension MutableCollection {
    /// [CHUtils] Mutates every element in the collection.
    /// - Parameter transform: a closure that mutates an element.
    mutating func mutate(_ transform: (inout Element) -> Void) {
        for (offset, element) in enumerated() {
            var copy = element
            let index = self.index(self.startIndex, offsetBy: offset)
            transform(&copy)
            self[index] = copy
        }
    }
}
