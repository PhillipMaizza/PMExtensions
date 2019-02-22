//
//  UITableViewCellExtensions.swift
//  PMExtensions
//
//  Created by Phillip Maizza on 22/02/2019.
//  Copyright © 2019 Phillip Maizza. All rights reserved.
//

import Foundation

extension UITableViewCell: CellIdentifiable {

	/// Enables or disables a cell
	public func toggle(on: Bool) {
		isUserInteractionEnabled = on
		contentView.subviews.forEach({
			$0.isUserInteractionEnabled = on
			$0.alpha = on ? 1 : 0.5
		})
	}

}
