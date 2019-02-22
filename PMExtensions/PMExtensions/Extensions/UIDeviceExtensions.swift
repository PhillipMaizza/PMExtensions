//
//  UIDeviceExtensions.swift
//  PMExtensions
//
//  Created by Phillip Maizza on 22/02/2019.
//  Copyright © 2019 Phillip Maizza. All rights reserved.
//

import Foundation

public extension UIDevice {

	/// Returns a bool if the current device is an iPhone
	public var iPhone: Bool {
		return UIDevice().userInterfaceIdiom == .phone
	}

	/// Returns a bool if the current device is an iPad
	public var iPad: Bool {
		return UIDevice().userInterfaceIdiom == .pad
	}

	/// Returns a bool if the current device is an iPhone 4 or 5
	public var smallScreeniPhone: Bool {
		return UIDevice.current.iPhoneType == .iPhone4 || UIDevice.current.iPhoneType == .iPhone5
	}

	public enum ScreenType: String {
		case iPhone4
		case iPhone5
		case iPhone6
		case iPhone6Plus
		case iPhoneX
		case unknown
	}

	/// Returns the type of the iPhone of the current device
	public var iPhoneType: ScreenType {
		guard iPhone else { return .unknown}

		switch UIScreen.main.nativeBounds.height {
		case 960:
			return .iPhone4
		case 1136:
			return .iPhone5
		case 1334:
			return .iPhone6
		case 2208:
			return .iPhone6Plus
		case 1624, 1792, 2436, 2688:
			return .iPhoneX

		default:
			return .unknown
		}
	}
}
