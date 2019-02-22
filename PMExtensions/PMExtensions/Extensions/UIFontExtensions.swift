//
//  UIFontExtensions.swift
//  PMExtensions
//
//  Created by Phillip Maizza on 22/02/2019.
//  Copyright © 2019 Phillip Maizza. All rights reserved.
//

import Foundation

public extension UIFont {

	public enum Light {
		/// Returns an extra small light font
		public static var extraSmall: UIFont {
			return UIFont.systemFont(ofSize: FontDimension.extraSmall, weight: UIFont.Weight.light)
		}

		/// Returns a small light font
		public static var small: UIFont {
			return UIFont.systemFont(ofSize: FontDimension.small, weight: UIFont.Weight.light)
		}

		/// Returns a normal light font
		public static var normal: UIFont {
			return UIFont.systemFont(ofSize: FontDimension.normal, weight: UIFont.Weight.light)
		}

		/// Returns a big light font
		public static var big: UIFont {
			return UIFont.systemFont(ofSize: FontDimension.big, weight: UIFont.Weight.light)
		}

		/// Returns a huge light font
		public static var huge: UIFont {
			return UIFont.systemFont(ofSize: FontDimension.huge, weight: UIFont.Weight.light)
		}

	}

	public enum Regular {
		/// Returns an extra small regular font
		public static var extraSmall: UIFont {
			return UIFont.systemFont(ofSize: FontDimension.extraSmall, weight: UIFont.Weight.regular)
		}

		/// Returns a small regular font
		public static var small: UIFont {
			return UIFont.systemFont(ofSize: FontDimension.small, weight: UIFont.Weight.regular)
		}

		/// Returns a normal regular font
		public static var normal: UIFont {
			return UIFont.systemFont(ofSize: FontDimension.normal, weight: UIFont.Weight.regular)
		}

		/// Returns a big regular font
		public static var big: UIFont {
			return UIFont.systemFont(ofSize: FontDimension.big, weight: UIFont.Weight.regular)
		}

		/// Returns a huge regular font
		public static var huge: UIFont {
			return UIFont.systemFont(ofSize: FontDimension.huge, weight: UIFont.Weight.regular)
		}

	}

	public enum Medium {
		/// Returns an extra small medium font
		public static var extraSmall: UIFont {
			return UIFont.systemFont(ofSize: FontDimension.extraSmall, weight: UIFont.Weight.medium)
		}

		/// Returns a small medium font
		public static var small: UIFont {
			return UIFont.systemFont(ofSize: FontDimension.small, weight: UIFont.Weight.medium)
		}

		/// Returns a normal medium font
		public static var normal: UIFont {
			return UIFont.systemFont(ofSize: FontDimension.normal, weight: UIFont.Weight.medium)
		}

		/// Returns a big medium font
		public static var big: UIFont {
			return UIFont.systemFont(ofSize: FontDimension.big, weight: UIFont.Weight.medium)
		}

		/// Returns a huge medium font
		public static var huge: UIFont {
			return UIFont.systemFont(ofSize: FontDimension.huge, weight: UIFont.Weight.medium)
		}

	}

	private enum FontDimension {

		static var extraSmall: CGFloat {
			return UIDevice.current.userInterfaceIdiom == .phone ? 11 : 13
		}

		static var small: CGFloat {
			return UIDevice.current.userInterfaceIdiom == .phone ? 13 : 15
		}

		static var normal: CGFloat {
			return UIDevice.current.userInterfaceIdiom == .phone ? 15 : 17
		}

		static var big: CGFloat {
			return UIDevice.current.userInterfaceIdiom == .phone ? 17 : 19
		}

		static var huge: CGFloat {
			return UIDevice.current.userInterfaceIdiom == .phone ? 20 : 25
		}
	}


	/// Returns a light system font of the specified size
	public class func lightSystemFont(ofSize size: CGFloat) -> UIFont {
		return UIFont.systemFont(ofSize: size, weight: UIFont.Weight.light)
	}

	/// Returns a regular system font of the specified size
	public class func regularSystemFont(ofSize size: CGFloat) -> UIFont {
		return UIFont.systemFont(ofSize: size, weight: UIFont.Weight.regular)
	}

	/// Returns a medium system font of the specified size
	public class func mediumSystemFont(ofSize size: CGFloat) -> UIFont {
		return UIFont.systemFont(ofSize: size, weight: UIFont.Weight.medium)
	}
}
