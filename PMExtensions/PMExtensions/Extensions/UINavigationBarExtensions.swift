//
//  UINavigationBarExtensions.swift
//  PMExtensions
//
//  Created by Phillip Maizza on 22/02/2019.
//  Copyright © 2019 Phillip Maizza. All rights reserved.
//

import Foundation

public extension UINavigationBar {

	/// Hides the 1px bottom bar of the navigation bar
	public func hideBottomHairline() {
		hairlineImageViewInNavigationBar(self)?.isHidden = true
	}

	/// Showss the 1px bottom bar of the navigation bar
	public func showBottomHairline() {
		hairlineImageViewInNavigationBar(self)?.isHidden = false
	}

	private func hairlineImageViewInNavigationBar(_ view: UIView) -> UIImageView? {
		if let imageView = view as? UIImageView, imageView.bounds.height <= 1 {
			return imageView
		}

		var imageView: UIImageView?

		view.subviews.forEach({
			if let iv = hairlineImageViewInNavigationBar($0) {
				imageView = iv
			}
		})

		return imageView
	}
}
