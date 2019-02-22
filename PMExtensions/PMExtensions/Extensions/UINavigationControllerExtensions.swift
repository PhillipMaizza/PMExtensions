//
//  UINavigationControllerExtensions.swift
//  PMExtensions
//
//  Created by Phillip Maizza on 22/02/2019.
//  Copyright © 2019 Phillip Maizza. All rights reserved.
//

import Foundation

public extension UINavigationController {

	/// Configures a transparent navigation bar
	public func configureTransparentNavBar() {
		navigationBar.setBackgroundImage(UIImage(), for: .default)
		navigationBar.shadowImage = UIImage()
		navigationBar.isTranslucent = true
		navigationBar.tintColor = .white
		navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
		view.backgroundColor = UIColor.clear
	}

	/// Hides the back button
	public func hideBackButton() {
		navigationItem.hidesBackButton = true
	}

	/// Pops to root view controller with a completion handler
	public func popToRootViewControllerWithHandler(_ completion: @escaping () -> Void) {
		CATransaction.begin()
		CATransaction.setCompletionBlock(completion)
		popToRootViewController(animated: true)
		CATransaction.commit()
	}

	/// Pops a view controller with a completion handler
	public func popViewControllerWithHandler(_ completion: @escaping () -> Void) {
		CATransaction.begin()
		CATransaction.setCompletionBlock(completion)
		popViewController(animated: true)
		CATransaction.commit()
	}

	/// Pushes the view controller with a completion handler
	public func pushViewController(_ viewController: UIViewController, completion: @escaping () -> Void) {
		CATransaction.begin()
		CATransaction.setCompletionBlock(completion)
		pushViewController(viewController, animated: true)
		CATransaction.commit()
	}

	/// Adds an activity indicator as a bar button item (right)
	public func addRightActivityIndicator(style: UIActivityIndicatorView.Style = .white) {
		let spinner = UIActivityIndicatorView(style: style)
		self.topViewController?.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: spinner)
	}

	/// Adds an activity indicator as a bar button item (left)
	public func addLeftActivityIndicator(style: UIActivityIndicatorView.Style = .white) {
		let spinner = UIActivityIndicatorView(style: style)
		topViewController?.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: spinner)
	}

	public func configure(withTitle title: String, color: UIColor) {
		navigationBar.hideBottomHairline()
		navigationBar.isTranslucent = false
		navigationBar.barTintColor = color
		navigationBar.tintColor = UIColor.white
		navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
		topViewController?.title = title
		topViewController?.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
	}

	/// Adds a left done button that closes the current modal controller
	public func addLeftDoneButton() {
		let barButton = UIBarButtonItem(barButtonSystemItem: .done, target: self.topViewController, action: #selector(self.topViewController?.close))
		self.topViewController?.navigationItem.leftBarButtonItem = barButton
	}

	/// Adds a right done button that closes the current modal controller
	public func addRightDoneButton() {
		let barButton = UIBarButtonItem(barButtonSystemItem: .done, target: self.topViewController, action: #selector(self.topViewController?.close))
		self.topViewController?.navigationItem.rightBarButtonItem = barButton
	}

	/// Adds a right cancel button that closes the current modal controller
	public func addRightCancelButton() {
		let barButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self.topViewController, action: #selector(self.topViewController?.close))
		self.topViewController?.navigationItem.rightBarButtonItem = barButton
	}

	/// Adds a left cancel button that closes the current modal controller
	public func addLeftCancelButton() {
		let barButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self.topViewController, action: #selector(self.topViewController?.close))
		self.topViewController?.navigationItem.leftBarButtonItem = barButton
	}


	/// Resolves a bug that prevented to show detected events inside a text view inside a modal view controller
	override open func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?) {

		var presentingVC: UIViewController = self
		while let presentedVC = presentingVC.presentedViewController {
			presentingVC = presentedVC
		}
		if presentingVC == self {
			super.present(viewControllerToPresent, animated: flag, completion: completion)
		} else {
			presentingVC.present(viewControllerToPresent, animated: flag, completion: completion)
		}

	}

}
