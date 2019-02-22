//
//  CellIdentifiable.swift
//  PMExtensions
//
//  Created by Phillip Maizza on 22/02/2019.
//  Copyright © 2019 Phillip Maizza. All rights reserved.
//

import Foundation

public protocol CellIdentifiable {
	static var cellID: String { get }
}

public extension CellIdentifiable {
	/// Returns a cell identifier describing T
	/// Example: MyCell.cellID will return "MyCell" as identifier for reusing it
	public static var cellID: String { return String(describing: self) }
}
