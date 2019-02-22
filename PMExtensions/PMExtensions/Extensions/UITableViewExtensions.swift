//
//  UITableViewExtensions.swift
//  PMExtensions
//
//  Created by Phillip Maizza on 22/02/2019.
//  Copyright © 2019 Phillip Maizza. All rights reserved.
//

import Foundation

public extension UITableView {

	/// Reloads data animated
	public func reloadDataAnimated(duration: Double = 0.15) {
		UIView.transition(with: self, duration: duration, options: [.transitionCrossDissolve], animations: { () -> Void in
			self.reloadData()
		}, completion: nil)
	}

	/// Registers a cell while declaring the table view
	public func register<T: UITableViewCell>(_ class: T.Type) {
		register(`class`, forCellReuseIdentifier: T.cellID)
	}

	/// Dequeues a cell using the following syntax:
	/// let cell: T = tableView.dequeueReusableCell(for: indexPath)
	public func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
		guard let cell = dequeueReusableCell(withIdentifier: T.cellID, for: indexPath) as? T else {
			return T()
		}
		return cell
	}
}
