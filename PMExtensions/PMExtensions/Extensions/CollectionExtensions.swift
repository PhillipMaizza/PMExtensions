//
//  ArrayExtensions.swift
//  PMExtensions
//
//  Created by Phillip Maizza on 22/02/2019.
//  Copyright © 2019 Phillip Maizza. All rights reserved.
//

import Foundation

public extension Collection {
	/// Returns the element at the specified index iff it is within bounds, otherwise nil
	subscript (safe index: Index) -> Element? {
		return indices.contains(index) ? self[index] : nil
	}
}

public extension MutableCollection {
	/// Shuffles the contents of the collection
	public mutating func shuffle() {
		let countVar = count
		guard countVar > 1 else { return }

		for (firstUnshuffled, unshuffledCount) in zip(indices, stride(from: countVar, to: 1, by: -1)) {
			let distance = Int(arc4random_uniform(numericCast(unshuffledCount)))
			let idx = index(firstUnshuffled, offsetBy: distance)
			swapAt(firstUnshuffled, idx)
		}
	}
}


