//
//  UICollectionViewExtensions.swift
//  PMExtensions
//
//  Created by Phillip Maizza on 22/02/2019.
//  Copyright © 2019 Phillip Maizza. All rights reserved.
//

import Foundation

public extension UICollectionView {

	/// Registers a cell while declaring the collection view
	public func register<T: UICollectionViewCell>(_ class: T.Type) {
		register(`class`, forCellWithReuseIdentifier: T.cellID)
	}

	/// Dequeues a cell
	/// Example: let cell: T = collectionView.dequeueReusableCell(for: indexPath)
	public func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
		guard let cell = dequeueReusableCell(withReuseIdentifier: T.cellID, for: indexPath) as? T else {
			return T()
		}
		return cell
	}
}
