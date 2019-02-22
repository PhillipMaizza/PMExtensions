//
//  UIStackViewExtensions.swift
//  PMExtensions
//
//  Created by Phillip Maizza on 22/02/2019.
//  Copyright © 2019 Phillip Maizza. All rights reserved.
//

import Foundation

public extension UIStackView {

	/// Returns an horizontal stack view with the specified parameters
	public static func horizontal(withSubviews subviews: [UIView], alignment: UIStackView.Alignment, distribution: UIStackView.Distribution, spacing: CGFloat) -> UIStackView {

		let stackView = UIStackView(arrangedSubviews: subviews)
		stackView.alignment = alignment
		stackView.spacing = spacing
		stackView.distribution = distribution
		stackView.axis = .horizontal
		return stackView
	}

	/// Returns a vertical stack view with the specified parameters
	public static func vertical(withSubviews subviews: [UIView], alignment: UIStackView.Alignment, distribution: UIStackView.Distribution, spacing: CGFloat) -> UIStackView {
		let stackView = UIStackView(arrangedSubviews: subviews)
		stackView.alignment = alignment
		stackView.spacing = spacing
		stackView.distribution = distribution
		stackView.axis = .vertical
		return stackView
	}

}
