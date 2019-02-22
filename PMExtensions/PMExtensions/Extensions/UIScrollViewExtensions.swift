//
//  UIScrollViewExtensions.swift
//  PMExtensions
//
//  Created by Phillip Maizza on 22/02/2019.
//  Copyright © 2019 Phillip Maizza. All rights reserved.
//

import Foundation

public extension UIScrollView {

	/// Scrolls to the top of the scroll view
	public func scrollToTop(animated: Bool = true) {
		let topOffset = CGPoint(x: 0, y: -contentInset.top)
		setContentOffset(topOffset, animated: animated)
	}

	/// Scrolls to the bottom of the scroll view
	public func scrollToBottom(animated: Bool = true) {
		let bottomOffset = CGPoint(x: 0, y: contentSize.height - bounds.size.height + contentInset.bottom)
		if bottomOffset.y > 0 {
			setContentOffset(bottomOffset, animated: animated)
		}
	}
}
