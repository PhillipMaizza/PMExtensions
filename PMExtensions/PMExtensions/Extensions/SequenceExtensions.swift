//
//  SequenceExtensions.swift
//  PMExtensions
//
//  Created by Phillip Maizza on 22/02/2019.
//  Copyright © 2019 Phillip Maizza. All rights reserved.
//

import Foundation

public extension Sequence {
	/// Returns an array with the contents of this sequence, shuffled.
	public func shuffled() -> [Element] {
		var result = Array(self)
		result.shuffle()
		return result
	}
}

public extension Sequence where Iterator.Element: Hashable {
	/// Returns an unique set without duplicates
	public func unique() -> [Iterator.Element] {
		var seen = Set<Iterator.Element>()
		return filter { seen.update(with: $0) == nil }
	}
}

public extension Array where Element: Equatable {
	/// Inserts a new object into an array if not existent
	///
	/// - Parameters:
	///   - item: object to insert
	///   - shouldRemove: ’true removes the object before inserting it
	public mutating func appendIfNotContains(_ item: Element, shouldRemove: Bool = false) {
		if shouldRemove {
			if let index = index(of: item) {
				remove(at: index)
			}
		}

		if !contains(item) {
			append(item)
		}

	}

	/// Removes duplicates from an array
	public mutating func removeDuplicates() {
		self = reduce(into: [Element]()) {
			if !$0.contains($1) {
				$0.append($1)
			}
		}
	}

	/// Returns an array without duplicates
	public func withoutDuplicates() -> [Element] {
		return reduce(into: [Element]()) {
			if !$0.contains($1) {
				$0.append($1)
			}
		}
	}
}
