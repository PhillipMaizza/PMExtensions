//
//  UIImageViewExtensions.swift
//  PMExtensions
//
//  Created by Phillip Maizza on 22/02/2019.
//  Copyright © 2019 Phillip Maizza. All rights reserved.
//

import Foundation

public extension UIImageView {

	/// Returns a gray disclosure indicator if the color parameters is not specified
	///
	public static func disclosure(color: UIColor? = nil) -> UIImageView {
		let iv = UIImageView()
		iv.image = UIImage(named: "disclosureIndicator")
		if let color = color {
			iv.image = UIImage(named: "disclosureIndicator")?.template
			iv.tintColor = color
		}
		iv.contentMode = .scaleAspectFit
		return iv
	}

	/// Sets an image and adds a tint color to it
	public func setImage(_ name: String, tintColor: UIColor) {
		self.image = UIImage(named: name)?.template
		self.tintColor = tintColor
	}

	/// Sets an image from remote
	/// Parameters:
	///    - url: the remote url
	///    - spinnerStyle: the style of the activity indicator while downloading, defaults to gray
//	public func setRemoteImage(withURL url: String, spinnerStyle: UIActivityIndicatorView.Style? = .gray, tintColor: UIColor? = nil) {
//		self.sd_setShowActivityIndicatorView(true)
//		self.sd_setIndicatorStyle(spinnerStyle!)
//		let block: SDExternalCompletionBlock = {(image, error, cache, imageURL) -> Void in
//			if image != nil {
//				if let tintColor =  tintColor {
//					self.image = image?.template
//					self.tintColor = tintColor
//				} else {
//					self.image = image
//				}
//			}
//		}
//
//		self.sd_setImage(with: URL(string: url), completed: block)
//	}

	/// Makes the image view blurry
	///
	/// - Parameter style: UIBlurEffectStyle (default is .light).
	public func blur(withStyle style: UIBlurEffect.Style = .light) {
		let blurEffect = UIBlurEffect(style: style)
		let blurEffectView = UIVisualEffectView(effect: blurEffect)
		blurEffectView.frame = bounds
		blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
		addSubview(blurEffectView)
		clipsToBounds = true
	}

}
