//
//  UIViewControllerExtensions.swift
//  PMExtensions
//
//  Created by Phillip Maizza on 22/02/2019.
//  Copyright © 2019 Phillip Maizza. All rights reserved.
//

import Foundation

public extension UIViewController {

	/// Returns a bool indicating whether the controller is visible or not
	public var isVisible: Bool {
		return isViewLoaded && view.window != nil
	}

	/// Returns a bool indicating whether the controller is the top view controller or not
	public var isTopViewController: Bool {
		if navigationController != nil {
			return navigationController?.visibleViewController === self
		} else if tabBarController != nil {
			return tabBarController?.selectedViewController == self && presentedViewController == nil
		} else {
			return presentedViewController == nil && isVisible
		}
	}

	/// Returns the topmost view controller
	class var topmostViewController: UIViewController? {
		if var viewController = UIApplication.shared.keyWindow?.rootViewController {
			while viewController.presentedViewController != nil {
				viewController = viewController.presentedViewController!
			}
			return viewController
		}
		return nil
	}

	/// Adds a fade transition at the dismissal of any popup
	func addFadeTransition(duration: Double = 0.25) {
		let transition = CATransition()
		transition.duration = duration
		transition.type = CATransitionType.fade
		view.window?.layer.add(transition, forKey: nil)
	}

	/// Updates the status bar appearance animated
	func animateStatusBarChange(_ duration: Double = 0) {
		UIView.animate(withDuration: duration) {
			self.setNeedsStatusBarAppearanceUpdate()
		}
	}

	/// Dismisses a modal stack
	func dismissModalStack(animated: Bool, completion: (() -> Void)?) {
		if let fullscreenSnapshot = UIApplication.shared.delegate?.window??.snapshotView(afterScreenUpdates: false) {
			presentedViewController?.view.addSubview(fullscreenSnapshot)
		}
		if !isBeingDismissed {
			dismiss(animated: animated, completion: completion)
		}
	}

	/// Dismisses the current view controller (modal only)
	@objc public func close() {
		dismiss(animated: true, completion: nil)
	}

	/// Closes all modal view controllers with a completion
	public class func closeModalViewControllers(_ completion: (() -> Void)? = nil ) {
		var viewController = UIViewController.topmostViewController
		var viewControllerToPop: UIViewController?
		while viewController != nil {
			viewControllerToPop = viewController?.presentingViewController

			if viewController!.presentingViewController != nil {
				viewController!.dismiss(animated: false, completion: nil)
			}

			viewController = viewControllerToPop
		}

		completion?()
	}

	/// Presents a view controller inside a navigation controller
	public func presentWithNavigationController(rootViewController: UIViewController, animated: Bool = true, completion:(() -> Void)? = nil) {
		let navigationController = UINavigationController(rootViewController: rootViewController)
		self.present(navigationController, animated: true, completion: completion)
	}

	/// Returns to the specified view controller
	class func returnToRootViewController(_ completion: (() -> Void)? = nil ) {
		var viewController = UIViewController.topmostViewController
		var viewControllerToPop: UIViewController?
		while viewController != nil {
			viewControllerToPop = viewController?.presentingViewController

			if let vc = viewController as? UINavigationController {
				vc.popToRootViewController(animated: false)
			}

			if viewController!.presentingViewController != nil {
				viewController!.dismiss(animated: false, completion: nil)
			}

			viewController = viewControllerToPop
		}

		if let viewControllerToPopNav = viewControllerToPop as? UINavigationController {
			viewControllerToPopNav.popToRootViewControllerWithHandler({ () -> Void in
				completion?()
			})
		} else {
			completion?()
		}
	}

}
