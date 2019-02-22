//
//  UILabelExtensions.swift
//  PMExtensions
//
//  Created by Phillip Maizza on 22/02/2019.
//  Copyright © 2019 Phillip Maizza. All rights reserved.
//

import Foundation

public extension UILabel {

	public struct Style {
	/// Returns a standard label with the specified parameters
		public static func standard(withText text: String = "", textColor: UIColor = .black, font: UIFont = UIFont.Regular.normal, textAlignment: NSTextAlignment = .left) -> UILabel {
			let lbl = UILabel()
			lbl.textColor = textColor
			lbl.font = font
			lbl.text = text
			lbl.numberOfLines = 0
			lbl.textAlignment = textAlignment
			return lbl
		}

		/// Returns a title label with the specified parameters
		public static func title(withText text: String = "", textColor: UIColor = .black, font: UIFont = UIFont.Medium.big, textAlignment: NSTextAlignment = .left) -> UILabel {
			let lbl = UILabel()
			lbl.textColor = textColor
			lbl.font = font
			lbl.text = text.uppercased()
			lbl.numberOfLines = 0
			lbl.lineBreakMode = .byWordWrapping
			lbl.textAlignment = textAlignment
			return lbl
		}

		/// Returns a description label with the specified parameters
		public static func description(withText text: String = "", textColor: UIColor = .darkGray, font: UIFont = UIFont.Regular.normal, textAlignment: NSTextAlignment = .left) -> UILabel {
			let lbl = UILabel()
			lbl.textColor = textColor
			lbl.font = font
			lbl.text = text
			lbl.numberOfLines = 0
			lbl.lineBreakMode = .byWordWrapping
			lbl.textAlignment = textAlignment
			return lbl
		}
	}
}
