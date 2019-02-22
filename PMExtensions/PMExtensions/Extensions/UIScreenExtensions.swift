//
//  UIScreenExtensions.swift
//  PMExtensions
//
//  Created by Phillip Maizza on 22/02/2019.
//  Copyright © 2019 Phillip Maizza. All rights reserved.
//

import Foundation

public extension UIScreen {
	/// Returns the total height of the screen
	public static var height: CGFloat {
		return UIScreen.main.bounds.height
	}

	/// Returns half of the height of the screen
	public static var halfHeight: CGFloat {
		return UIScreen.main.bounds.height / 2
	}

	/// Returns one third of the height of the screen
	public static var oneThirdHeight: CGFloat {
		return UIScreen.main.bounds.height / 3
	}

	/// Returns one fourth of the height of the screen
	public static var oneFourthHeight: CGFloat {
		return UIScreen.main.bounds.height / 4
	}

	/// Returns one fifth of the height of the screen
	public static var oneFifthHeight: CGFloat {
		return UIScreen.main.bounds.height / 5
	}

	/// Returns one sixth of the height of the screen
	public static var oneSixthHeight: CGFloat {
		return UIScreen.main.bounds.height / 6
	}

	/// Returns the total width of the screen
	public static var width: CGFloat {
		return UIScreen.main.bounds.width
	}

	/// Returns half the width of the screen
	public static var halfWidth: CGFloat {
		return UIScreen.main.bounds.width / 2
	}

	/// Returns one third of the width of the screen
	public static var oneThirdWidth: CGFloat {
		return UIScreen.main.bounds.width / 3
	}

	/// Returns one fourth of the width of the screen
	public static var oneFourthWidth: CGFloat {
		return UIScreen.main.bounds.height / 4
	}

	/// Returns one fifth of the width of the screen
	public static var oneFifthWidth: CGFloat {
		return UIScreen.main.bounds.height / 5
	}

	/// Returns one sixth of the width of the screen
	public static var oneSixthWidth: CGFloat {
		return UIScreen.main.bounds.height / 6
	}
}
