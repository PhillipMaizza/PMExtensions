//
//  UIControlExtensions.swift
//  PMExtensions
//
//  Created by Phillip Maizza on 22/02/2019.
//  Copyright © 2019 Phillip Maizza. All rights reserved.
//

import Foundation

public class ClosureSleeve {
	let closure: () -> Void

	init(attachTo: AnyObject, closure: @escaping () -> Void) {
		self.closure = closure
		objc_setAssociatedObject(attachTo, "[\(arc4random())]", self, .OBJC_ASSOCIATION_RETAIN)
	}

	@objc func invoke() {
		closure()
	}
}

public extension UIControl {

	/// Adds a block action to any UIControl
	public func addAction(for controlEvents: UIControl.Event = .primaryActionTriggered, action: @escaping () -> Void) {
		let sleeve = ClosureSleeve(attachTo: self, closure: action)
		addTarget(sleeve, action: #selector(ClosureSleeve.invoke), for: controlEvents)
	}
}
