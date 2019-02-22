//
//  BoundsExtensions.swift
//  PMExtensions
//
//  Created by Phillip Maizza on 22/02/2019.
//  Copyright © 2019 Phillip Maizza. All rights reserved.
//

import Foundation

public extension CountableClosedRange where Bound == Int {
	/// Returns random number within given range, upper bound included, eg. -1...0 = [-1, 0, 1]
	public var random: Int {
		let range = self
		let offset: Int = range.lowerBound < 0 ? abs(range.lowerBound) : 0
		let min = UInt32(range.lowerBound + offset)
		let max = UInt32(range.upperBound + offset)
		let randomNumber = Int(min + arc4random_uniform(max - min + 1)) - offset

		return randomNumber
	}
}

public extension CountableRange where Bound == Int {
	/// Returns random number within given range, upper bound not included, eg. -1...0 = [-1, 0]
	public var random: Int {
		let range = self
		let offset: Int = range.lowerBound < 0 ? abs(range.lowerBound) : 0
		let min = UInt32(range.lowerBound + offset)
		let max = UInt32(range.upperBound + offset)
		let randomNumber = Int(min + arc4random_uniform(max - min)) - offset
		return randomNumber
	}
}
