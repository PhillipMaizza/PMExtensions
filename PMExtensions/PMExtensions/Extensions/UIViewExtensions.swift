//
//  UIViewExtensions.swift
//  PMExtensions
//
//  Created by Phillip Maizza on 22/02/2019.
//  Copyright © 2019 Phillip Maizza. All rights reserved.
//

import Foundation

public struct PlaceholderViewButtonConfiguration {
	var title: String
	var action: ButtonActionBlock
	var titleColor: UIColor
	var backgroundColor: UIColor

	init(title: String, action: @escaping ButtonActionBlock, titleColor: UIColor = .white, backgroundColor: UIColor) {
		self.title = title
		self.action = action
		self.titleColor = titleColor
		self.backgroundColor = backgroundColor
	}
}

public struct PlaceholderViewConfiguration {
	var title: String
	var description: String
	var image: UIImage?
	var imageSize: CGSize
	var imageTintColor: UIColor?
	var roundImage: Bool

	init(title: String, description: String, image: UIImage?, imageSize: CGSize = CGSize(width: 75, height: 75), imageTintColor: UIColor? = nil, roundImage: Bool = true) {
		self.title = title
		self.description = description
		self.image = image
		self.imageSize = imageSize
		self.imageTintColor = imageTintColor
		self.roundImage = roundImage
	}
}

public extension UIView {

	/// Returns a blurred visual effect view
	public static func blurred(withStyle style: UIBlurEffect.Style = .dark) -> UIVisualEffectView {
		return UIVisualEffectView(effect: UIBlurEffect(style: style))
	}

	/// Adds background image
	public func addBackground(image: UIImage?, contentMode: UIView.ContentMode = .scaleToFill) {
		// setup the UIImageView
		let backgroundImageView = UIImageView(frame: UIScreen.main.bounds)
		backgroundImageView.image = image
		backgroundImageView.contentMode = contentMode
		backgroundImageView.translatesAutoresizingMaskIntoConstraints = false

		addSubview(backgroundImageView)
		sendSubviewToBack(backgroundImageView)

		// adding NSLayoutConstraints
		let leadingConstraint = NSLayoutConstraint(item: backgroundImageView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0.0)
		let trailingConstraint = NSLayoutConstraint(item: backgroundImageView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0.0)
		let topConstraint = NSLayoutConstraint(item: backgroundImageView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0.0)
		let bottomConstraint = NSLayoutConstraint(item: backgroundImageView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0.0)

		NSLayoutConstraint.activate([leadingConstraint, trailingConstraint, topConstraint, bottomConstraint])
	}

	/// Returns a placeholder view with a configuration
	public class func placeholder(withConfiguration viewConfiguration: PlaceholderViewConfiguration, buttonConfiguration: PlaceholderViewButtonConfiguration?) -> UIView {

		let viewBackground: UIView = {
			let view =  UIView()
			view.backgroundColor = .clear
			return view
		}()

		let button: UIButton = {
			let btn = UIButton()
			btn.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
			if let configuration = buttonConfiguration {
				btn.configure(withTitle: configuration.title, color: configuration.backgroundColor, textColor: configuration.titleColor)
				btn.layer.borderColor = configuration.backgroundColor.cgColor
				btn.layer.borderWidth = 1.5
				btn.addAction(for: .touchUpInside, action: configuration.action)
			}

			btn.isUserInteractionEnabled = true
			return btn
		}()

		let imageView: UIImageView = {
			let imageView = UIImageView()

			if let tintColor = viewConfiguration.imageTintColor {
				imageView.image = viewConfiguration.image?.template
				imageView.tintColor = tintColor
			} else {
				imageView.image = viewConfiguration.image
			}

			imageView.set(width: viewConfiguration.imageSize.width)
			imageView.set(height: viewConfiguration.imageSize.height)
			if viewConfiguration.roundImage {
				imageView.roundCorners(viewConfiguration.imageSize.width / 2)
			}

			return imageView
		}()

		let labelTitle: UILabel = {
			let lbl = UILabel()
			lbl.textColor = .black
			lbl.font = UIFont.Medium.big
			lbl.text = viewConfiguration.title.uppercased()
			lbl.textAlignment = .center
			lbl.translatesAutoresizingMaskIntoConstraints = false
			return lbl
		}()

		let labelDescription: UILabel = {
			let lbl = UILabel()
			lbl.textColor = .darkGray
			lbl.font = UIFont.Regular.normal
			lbl.numberOfLines = 0
			lbl.textAlignment = .center
			lbl.translatesAutoresizingMaskIntoConstraints = false
			lbl.text = viewConfiguration.description

			return lbl
		}()

		let stackView = UIStackView.vertical(withSubviews: [imageView, labelTitle, labelDescription, button], alignment: .center, distribution: .fill, spacing: 8)

		viewBackground.addSubview(stackView)

		viewBackground.addConstraint(NSLayoutConstraint(item: stackView, attribute: .centerX, relatedBy: .equal, toItem: viewBackground, attribute: .centerX, multiplier: 1, constant: 0))
		viewBackground.addConstraint(NSLayoutConstraint(item: stackView, attribute: .centerY, relatedBy: .equal, toItem: viewBackground, attribute: .centerY, multiplier: 0.9, constant: 0))

		stackView.centerXAnchor.constraint(equalTo: viewBackground.centerXAnchor).isActive = true
		stackView.centerYAnchor.constraint(equalTo: viewBackground.centerYAnchor).isActive = true

		if UIDevice.current.iPad {
			stackView.widthAnchor.constraint(equalToConstant: 500).isActive = true
		} else {
			stackView.leadingAnchor.constraint(equalTo: viewBackground.leadingAnchor, constant: 16).isActive = true
			stackView.trailingAnchor.constraint(equalTo: viewBackground.trailingAnchor, constant: -16).isActive = true
		}

		button.heightAnchor.constraint(equalToConstant: 36).isActive = true

		imageView.heightAnchor.constraint(equalToConstant: viewConfiguration.imageSize.height).isActive = true
		imageView.widthAnchor.constraint(equalToConstant: viewConfiguration.imageSize.width).isActive = true

		viewBackground.isUserInteractionEnabled = true

		return viewBackground
	}

	/// Sets horizontal content compression resistance priority to the max
	public func setMaximumHorizontalContentCompressionResistance() {
		self.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 1000), for: .horizontal)
	}

	/// Sets horizontal content hugging priority to the max
	public func setMaximumHorizontalContentHuggingPriority() {
		self.setContentHuggingPriority(UILayoutPriority(rawValue: 1000), for: .horizontal)
	}

	/// Sets maximum vertical content compression resistance priority to the max
	public func setMaximumVerticalContentCompressionResistance() {
		self.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 1000), for: .vertical)
	}

	/// Sets vertical content hugging priority to the max
	public func setMaximumVerticalContentHuggingPriority() {
		self.setContentHuggingPriority(UILayoutPriority(rawValue: 1000), for: .vertical)
	}

	/// Sets both horizontal content compression and hugging
	public func setHorizontalCompressionAndHugging() {
		setMaximumHorizontalContentHuggingPriority()
		setMaximumHorizontalContentCompressionResistance()
	}

	/// Sets both vertical content compression and hugging
	public func setVerticalCompressionAndHugging() {
		setMaximumVerticalContentHuggingPriority()
		setMaximumVerticalContentCompressionResistance()
	}

	/// Returns a card view
	public static func card() -> UIView {
		let view = UIView()
		view.backgroundColor = .white
		view.roundCorners(15)
		view.addShadow()
		return view
	}

	/// Returns a view with an activity indicator in the middle of it
	public static func loading(_ backgroundColor: UIColor = .tableView, spinnerStyle: UIActivityIndicatorView.Style = .gray) -> UIView {
		let view = UIView()
		view.backgroundColor = backgroundColor
		view.addSpinner(withStyle: spinnerStyle)
		return view
	}

	/// Returns a separator view
	public static func separator(backgroundColor: UIColor = .lightGray) -> UIView {
		let view = UIView()
		view.alpha = 0.3
		view.backgroundColor = backgroundColor
		return view
	}

	/// Animates the layout change
	public func animateConstraints(duration: CGFloat = 0.25) {
		UIView.animate(withDuration: 0.25) {
			self.layoutIfNeeded()
		}
	}

	/// Gets and sets the maskToBounds layer property
	public var masksToBounds: Bool {
		get { return self.layer.masksToBounds }
		set { self.layer.masksToBounds = newValue }
	}

	/// Removes the subview with the specified tag
	public func removeSubviewWithTag(_ tag: Int) {
		for subview in self.subviews where subview.tag == tag {
			UIView.animate(withDuration: 0.2, animations: {
				subview.alpha = 0.0
			}, completion: { _ in
				subview.removeFromSuperview()
			})
		}
	}

	/// Anchors to all margins an item
	public func anchorItemToAllMargins(_ item: UIView, constantTop: CGFloat = 0, constantLeft: CGFloat = 0, constantRight: CGFloat = 0, constantBottom: CGFloat = 0) {
		self.addSubview(item)
		item.translatesAutoresizingMaskIntoConstraints = false
		item.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
		item.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
		item.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
		item.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
	}

	/// Shows a view animated
	public func showAnimated() {
		UIView.animate(withDuration: 0.25, animations: {
			self.alpha = 1
		}, completion: { _ in
			self.isHidden = false
		})
	}

	/// Hides a view animated
	public func hideAnimated() {
		if self.isHidden {
			return
		}

		UIView.animate(withDuration: 0.25, animations: {
			self.alpha = 0
		}, completion: { _ in
			self.isHidden = true
		})
	}

	/// Loads a view starting from a nib
	public class func loadFromNibNamed(_ nibNamed: String, bundle: Bundle? = nil) -> UIView? {
		return UINib(nibName: nibNamed, bundle: bundle).instantiate(withOwner: nil, options: nil)[0] as? UIView
	}

	/// Rounds all corners of the view
	public func roundCorners(_ cornerRadius: CGFloat) {
		layer.cornerRadius = cornerRadius
		clipsToBounds = true
		layer.masksToBounds = true
	}

	/// Rounds the specified corners of the view
	public func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
		let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
		let mask = CAShapeLayer()
		mask.path = path.cgPath
		layer.mask = mask
	}

	/// Adds a border to the view
	public func addBorder(width: CGFloat, color: UIColor) {
		layer.borderWidth = width
		layer.borderColor = color.cgColor
	}

	/// Adds a border and rounds all corner of the view
	public func addBorderAndRoundCorners(borderWidth: CGFloat, color: UIColor, cornerRadius: CGFloat) {
		self.roundCorners(cornerRadius)
		self.addBorder(width: borderWidth, color: color)
	}

	/// Adds a colored border on top of the view
	public func addTopBorderWithColor(_ color: UIColor, width: CGFloat) {
		let border = CALayer()
		border.backgroundColor = color.cgColor
		border.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: width)
		self.layer.addSublayer(border)
	}

	/// Adds a colored border on the right of the view
	public func addRightBorderWithColor(_ color: UIColor, width: CGFloat) {
		let border = CALayer()
		border.backgroundColor = color.cgColor
		border.frame = CGRect(x: self.frame.size.width - width, y: 0, width: width, height: self.frame.size.height)
		self.layer.addSublayer(border)
	}

	/// Adds a colored border on the bottom of the view
	public func addBottomBorderWithColor(_ color: UIColor, width: CGFloat) {
		let border = CALayer()
		border.backgroundColor = color.cgColor
		border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: width)
		self.layer.addSublayer(border)
	}

	/// Adds a colored border on the left of the view
	public func addLeftBorderWithColor(_ color: UIColor, width: CGFloat) {
		let border = CALayer()
		border.backgroundColor = color.cgColor
		border.frame = CGRect(x: 0, y: 0, width: width, height: self.frame.size.height)
		self.layer.addSublayer(border)
	}

	/// Adds a shadow to the view
	public func addShadow(opacity: Float = 0.08) {
		layer.shadowOffset = CGSize(width: 3, height: 3)
		layer.shadowRadius = 0.5
		layer.shadowOpacity = opacity
		layer.shouldRasterize = true
		layer.rasterizationScale = UIScreen.main.scale
		clipsToBounds = false
	}

	/// Rotates the view of a specified angle
	public func rotate(degrees: CGFloat) {
		transform = CGAffineTransform(rotationAngle: degrees * (CGFloat.pi / 180))
	}

	/// Ritorna la lunghezza della view
	public var getWidth: CGFloat { return self.frame.size.width }

	/// Ritorna l'altezza della view
	public var getHeight: CGFloat { return self.frame.size.height }

	/// Ritorna la dimensione della view
	public var getSize: CGSize { return self.frame.size }

	/// Ritorna i punti d'origine della view
	public var origin: CGPoint { return self.frame.origin }

	/// Ritorna l'origine orizzontale della view
	public var originX: CGFloat { return self.frame.origin.x }

	/// Ritorna l'origine verticale della view
	public var originY: CGFloat { return self.frame.origin.y }

	/// Ritorna il centro orizzontale della view
	public var centerX: CGFloat { return self.center.x }

	/// Ritorna il centro verticale della view
	public var centerY: CGFloat { return self.center.y }

	/// Setta la lunghezza della view
	public func set(width: CGFloat) {
		self.frame.size.width = width
	}

	/// Setta l'altezza della view
	public func set(height: CGFloat) {
		self.frame.size.height = height
	}

	/// Setta la dimensione della view
	public func set(size: CGSize) {
		self.frame.size = size
	}

	/// Setta l'origine orizzontale della view
	public func set(originX: CGFloat) {
		self.frame.origin = CGPoint(x: originX, y: self.frame.origin.y)
	}

	/// Setta l'origine verticale della view
	public func set(originY: CGFloat) {
		self.frame.origin = CGPoint(x: self.frame.origin.x, y: originY)
	}

	/// Setta il centro orizzontale della view
	public func set(centerX: CGFloat) {
		self.center = CGPoint(x: centerX, y: self.center.y)
	}

	/// Setta il centro verticale della view
	public func set(centerY: CGFloat) {
		self.center = CGPoint(x: self.center.x, y: centerY)
	}

	/// Setta la distanza superiore della view
	public func set(top: CGFloat) {
		self.frame.origin.y = top
	}

	/// Setta la distanza da sinistra della view
	public func set(left: CGFloat) {
		self.frame.origin.x = left
	}

	/// Setta la distanza da destra della view
	public func set(right: CGFloat) {
		self.frame.origin.x = right - self.frame.size.width
	}

	/// Setta la distanza inferiore della view
	public func set(bottom: CGFloat) {
		self.frame.origin.y = bottom - self.frame.size.height
	}

	/// Rotates the image 360 degrees with a completion
	public func rotate360Degrees(withDuration duration: CFTimeInterval = 1.0, completionDelegate: CAAnimationDelegate? = nil) {
		let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
		rotateAnimation.fromValue = 0.0
		rotateAnimation.toValue = CGFloat(.pi * 2.0)
		rotateAnimation.duration = duration

		if let delegate = completionDelegate {
			rotateAnimation.delegate = delegate
		}
		self.layer.add(rotateAnimation, forKey: nil)
	}

	/// Scales the image
	public func scale(withDuration duration: Double = 0.5) {
		UIView.animate(withDuration: duration, delay: 0, options: UIView.AnimationOptions(), animations: { () -> Void in
			self.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
		}, completion: { _ -> Void in
			UIView.animate(withDuration: 0.1, animations: { () -> Void in
				self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
			})
		})
	}

	/// Adds an activity indicator to a view
	public func addSpinner(withStyle style: UIActivityIndicatorView.Style, spinnerColor: UIColor? = nil) {
		let spinner = UIActivityIndicatorView(style: style)
		spinner.translatesAutoresizingMaskIntoConstraints = false
		spinner.tag = 4240
		if let color = spinnerColor {
			spinner.color = color
		}

		spinner.startAnimating()

		self.addSubview(spinner)

		//Constraint width/height
		spinner.addConstraint(NSLayoutConstraint(item: spinner, attribute: NSLayoutConstraint.Attribute.width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50))
		spinner.addConstraint(NSLayoutConstraint(item: spinner, attribute: NSLayoutConstraint.Attribute.height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50))

		//Constraint per centrare
		self.addConstraint(NSLayoutConstraint(item: spinner, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0))
		self.addConstraint(NSLayoutConstraint(item: spinner, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0))
	}

	/// Removes the activity indicator from the view
	@objc public func removeSpinner(_ tintColor: UIColor = UIColor.white) {
		self.subviews.forEach({
			if $0.tag == 4240 {
				$0.removeFromSuperview()
			}
		})

		if let btn = self as? UIButton {
			btn.setTitleColor(tintColor, for: .normal)
			btn.imageView?.layer.transform = CATransform3DIdentity
			btn.enableInteraction()
		}
	}

	/// Shakes the view
	public func shake() {
		let animation = CABasicAnimation(keyPath: "position")
		animation.duration = 0.1
		animation.repeatCount = 3
		animation.autoreverses = true
		animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 5, y: self.center.y))
		animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 5, y: self.center.y))
		self.layer.add(animation, forKey: "position")
	}

	/// Returns an image containing the screenshot of the view
	public var screenShot: UIImage {
		let bounds = self.bounds
		UIGraphicsBeginImageContextWithOptions(self.frame.size, true, UIScreen.main.scale)
		self.drawHierarchy(in: bounds, afterScreenUpdates: true)

		let image = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()

		return image!
	}

	/// Adds alpha animated
	public func addAlpha(amount: CGFloat, animated: Bool = false, duration: Double = 0.25) {
		if animated {
			UIView.animate(withDuration: duration, animations: {
				self.alpha = amount
			})
		} else {
			self.alpha = amount
		}
	}

	/// Dims alpha animated
	public func dimAlpha(animated: Bool = false, duration: Double = 0.25) {
		if animated {
			UIView.animate(withDuration: duration, animations: {
				self.alpha = 0.5
			})
		} else {
			self.alpha = 0.5
		}
	}

	/// Removes alpha animated
	public func removeAlpha(animated: Bool = false, duration: Double = 0.25) {
		if animated {
			UIView.animate(withDuration: duration, animations: {
				self.alpha = 0
			})
		} else {
			self.alpha = 0
		}
	}
}
