//
//  ValueTypesExtensions.swift
//  PMExtensions
//
//  Created by Phillip Maizza on 22/02/2019.
//  Copyright © 2019 Phillip Maizza. All rights reserved.
//

import Foundation

public extension Int {
	/// Returns a random number given a lower and a maximum (defaults to 0 and 100)
	public static func random(lower: Int = 0, _ upper: Int = 100) -> Int {
		return lower + Int(arc4random_uniform(UInt32(upper - lower + 1)))
	}
}

public extension Double {
	/// Returns a random number given a lower and a maximum (defaults to 0 and 100)
	public static func random(lower: Double = 0, _ upper: Double = 100) -> Double {
		return (Double(arc4random()) / 0xFFFFFFFF) * (upper - lower) + lower
	}
}

public extension Float {
	/// Returns a random number given a lower and a maximum (defaults to 0 and 100)
	public static func random(lower: Float = 0, _ upper: Float = 100) -> Float {
		return (Float(arc4random()) / 0xFFFFFFFF) * (upper - lower) + lower
	}
}

public extension CGFloat {
	/// Returns a random number given a lower and a maximum (defaults to 0 and 100)
	public static func random(lower: CGFloat = 0, _ upper: CGFloat = 1) -> CGFloat {
		return CGFloat(Float(arc4random()) / Float(UINT32_MAX)) * (upper - lower) + lower
	}
}
