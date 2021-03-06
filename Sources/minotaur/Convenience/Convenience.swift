
precedencegroup LeftAssociativePrecedence {
    associativity: left
}

infix operator | : LeftAssociativePrecedence

internal func | <T, U, V> (from: @escaping (T) -> U, to: @escaping (U) -> V) -> (T) -> V {
    return { to(from($0)) }
}

internal extension Array {

	internal static func populate(amount: Int, generator: () -> Element) -> Array {
		guard amount > 0 else { return [] }
		return (0 ..< amount).reduce([]) { array, _ in
			array + [generator()]
		}
	}
}

internal extension Sequence {

	internal func shifted(by shift: Int) -> Array<Element> {
		let loop = Loop(self)

		return (0 ..< loop.count).reduce([]) { array, i in
			array + [loop[i + shift]]
		}
	}
}

internal extension Array {

	internal func chunks(_ chunkSize: Int) -> [[Element]] {
		return stride(from: 0, to: self.count, by: chunkSize).map {
			Array(self[$0..<Swift.min($0 + chunkSize, self.count)])
		}
	}
}

internal extension Array {

	internal func sequentialPairs() -> Zip2Sequence<Array, Array> {
		let items = self
		var pairItems = items.shifted(by: 1)

		pairItems.removeLast()

		return zip(items, pairItems)
	}
}
