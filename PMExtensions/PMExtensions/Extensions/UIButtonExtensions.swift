//
//  UIButtonExtensions.swift
//  PMExtensions
//
//  Created by Phillip Maizza on 22/02/2019.
//  Copyright © 2019 Phillip Maizza. All rights reserved.
//

import Foundation

typealias ButtonActionBlock = () -> Void

public extension UIButton {
	public struct Main {
		/// Returns configured main button
		public static func configure(withTitle title: String = "", titleColor: UIColor = .white, backgroundColor: UIColor, cornerRadius: CGFloat = 20, horizontalPadding: CGFloat = 0, verticalPadding: CGFloat = 0, action: (() -> Void)? = nil) -> UIButton {
			let button = UIButton()
			button.layer.borderColor = backgroundColor.cgColor
			button.backgroundColor = backgroundColor
			button.clipsToBounds = true
			button.layer.masksToBounds = true
			button.layer.cornerRadius = button.getHeight / 2 == 0 ? 15 : button.getHeight / 2
			button.titleFont = UIFont.Medium.small
			button.title = title.uppercased()
			button.titleColor = titleColor
			button.isEnabled = true
			button.alpha = 1.0
			button.contentEdgeInsets = UIEdgeInsets(top: verticalPadding, left: horizontalPadding, bottom: verticalPadding, right: horizontalPadding)
			if let action = action {
				button.addAction {
					action()
				}
			}
			return button
		}
	}

	/// Gets and set the top margin
	var marginTop: CGFloat {
		get { return contentEdgeInsets.top }
		set { contentEdgeInsets.top = newValue }
	}

	/// Gets and set the left margin
	var marginLeft: CGFloat {
		get { return contentEdgeInsets.left }
		set { contentEdgeInsets.left = newValue }
	}

	/// Gets and set the right margin
	var marginRight: CGFloat {
		get { return contentEdgeInsets.right }
		set { contentEdgeInsets.right = newValue }
	}

	/// Gets and set the bottom margin
	var marginBottom: CGFloat {
		get { return contentEdgeInsets.bottom }
		set { contentEdgeInsets.bottom = newValue }
	}

	/// Gets and set the font of the title
	var titleFont: UIFont? {
		get { return titleLabel?.font }
		set { titleLabel?.font = newValue }
	}

	/// Gets and set the color of the title
	var titleColor: UIColor? {
		get { return titleColor(for: .normal) }
		set { setTitleColor(newValue, for: .normal) }
	}

	/// Gets and set the title
	var title: String? {
		get { return title(for: .normal) }
		set { setTitle(newValue, for: .normal) }
	}

	/// Gets and set the image
	var image: UIImage? {
		get { return image(for: .normal) }
		set { setImage(newValue, for: .normal) }
	}

	/// Adds an action
	func addAction(_ target: Any?, selector: Selector) {
		self.addTarget(target, action: selector, for: .touchUpInside)
	}

	/// Disables the button
	func disableInteraction(alpha: CGFloat = 0.5) {
		isUserInteractionEnabled = false
		isEnabled = false
		self.alpha = alpha
	}

	/// Enables the button
	func enableInteraction() {
		isUserInteractionEnabled = true
		isEnabled = true
		alpha = 1
	}

	/// Shows the button animated
	func show(animated: Bool = false, duration: Double = 0.25) {
		enableInteraction()
		isEnabled = true

		if animated {
			UIView.animate(withDuration: duration, animations: {
				self.alpha = 1
			}, completion: { _ in
				self.isHidden = false
			})
		} else {
			self.isHidden = false
		}
	}

	/// Hides the button animated
	func hide(animated: Bool = false, duration: Double = 0.25) {
		self.disableInteraction()
		self.isEnabled = false

		if animated {
			UIView.animate(withDuration: duration, animations: {
				self.alpha = 0
			}, completion: { _ in
				self.isHidden = true
			})
		} else {
			self.isHidden = true
		}

	}

	/// Configures a button with a background color and a white title
	func configureMain(withTitle title: String, backgroundColor: UIColor) {
		layer.borderColor = backgroundColor.cgColor
		self.backgroundColor = backgroundColor
		clipsToBounds = true
		layer.masksToBounds = true
		layer.cornerRadius = getHeight / 2 == 0 ? 15 : getHeight / 2 // 15
		titleFont = UIFont.Medium.small
		self.title = title.uppercased()
		titleColor = .white
		isEnabled = true
		alpha = 1.0
	}

	/// Configures a button with the specified parameters
	func configure(withTitle title: String, color: UIColor, textColor: UIColor) {
		layer.borderColor = color.cgColor
		backgroundColor = color
		layer.borderWidth = 1.5
		clipsToBounds = true
		layer.masksToBounds = true
		layer.cornerRadius = getHeight / 2 == 0 ? 20 : getHeight / 2
		titleFont = UIFont.Medium.small
		self.title = title.uppercased()
		titleColor = textColor
	}

	func configureSecondaryButton(withTitle title: String, color: UIColor) {
		layer.borderColor = color.cgColor
		layer.cornerRadius = getHeight / 2 == 0 ? 20 : getHeight / 2
		layer.masksToBounds = true
		clipsToBounds = true
		layer.borderWidth = 1.5
		titleFont = UIFont.Medium.small
		self.title = title.uppercased()
		titleColor = color
	}

	/// Configures a button with a background color and a white title
	func configureTutorialButton(_ title: String) {
		layer.borderColor = UIColor.white.cgColor
		layer.cornerRadius = getHeight / 2 == 0 ? 20 : getHeight / 2
		layer.masksToBounds = true
		clipsToBounds = true
		layer.borderWidth = 1.5
		titleFont = UIFont.Medium.small
		self.title = title.uppercased()
	}

	/// Rounds the button
	func roundButton() {
		self.roundCorners(self.getHeight / 2)
	}

	/// Toggles the button
	func toggle(enabled: Bool, animated: Bool = true, duration: Double = 0.25) {
		if animated {
			UIView.animate(withDuration: duration) {
				self.alpha = enabled ? 1 : 0.5
				self.isEnabled = enabled
			}
		} else {
			self.alpha = enabled ? 1 : 0.5
			self.isEnabled = enabled
		}
	}
}
