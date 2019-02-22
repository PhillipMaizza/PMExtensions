//
//  UIApplicationExtensions.swift
//  PMExtensions
//
//  Created by Phillip Maizza on 22/02/2019.
//  Copyright © 2019 Phillip Maizza. All rights reserved.
//

import Foundation

public extension UIApplication {

	/// Returns a bool indicating whether the app is in background or not
	public static var isInBackground: Bool {
		return self.shared.applicationState != .active
	}

	/// Returns the topmost view controller
	public static func topViewController(_ base: UIViewController? = UIApplication.shared.delegate?.window??.rootViewController) -> UIViewController? {
		if let nav = base as? UINavigationController {
			return topViewController(nav.visibleViewController)
		}
		if let tab = base as? UITabBarController {
			if let selected = tab.selectedViewController {
				return topViewController(selected)
			}
		}
		if let presented = base?.presentedViewController {
			return topViewController(presented)
		}
		return base
	}

	/// Cancels a local notification with the specified ID
	public func cancelLocalNotification(withID notificationID: String) {
		UIApplication.shared.scheduledLocalNotifications?.forEach({
			if let userInfo = $0.userInfo {
				if let id = userInfo["id"] as? String, id == notificationID {
					UIApplication.shared.cancelLocalNotification($0)
				}
			}
		})
	}

}
