//
//  UserDefaultsExtensions.swift
//  PMExtensions
//
//  Created by Phillip Maizza on 22/02/2019.
//  Copyright © 2019 Phillip Maizza. All rights reserved.
//

import Foundation

extension UserDefaults {

	/// Returns a bool indicating whether the user has completed the intro
	public var hasCompletedIntro: Bool {
		get { return self.bool(forKey: "hasCompletedIntro") }
		set { set(newValue, forKey: "hasCompletedIntro") }
	}

	/// Returns a bool indicating whether the app should show the review popup
	public var shouldShowReviewPopup: Bool {
		get { return bool(forKey: "showReviewPopup") }
		set { set(newValue, forKey: "showReviewPopup") }
	}

	/// Returns a bool indicating whether the app should force to show the review popup
	public var shouldForceShowReviewPopup: Bool {
		get { return bool(forKey: "forceShowReviewPopup") }
		set { set(newValue, forKey: "forceShowReviewPopup") }
	}

	/// Returns the app version made of "app version" + "bundle version"
	public var appVersion: Int {
		return value(forKey: "AppVersion") as? Int ?? 0
	}

	/// Saves the app version
	public func saveAppVersion() {
		set(Bundle.main.appAndBuildVersionNumber, forKey: "AppVersion")
	}

	/// Returns a bool indicating whether the user has just opened the app
	public var isFirstTimeAppOpening: Bool {
		get { return bool(forKey: "firstTimeOpening") }
		set { set(newValue, forKey: "firstTimeOpening") }
	}

	/// Returns the number of openings of the app
	public var numberOfAppOpenings: Int {
		return integer(forKey: "openingCount")
	}

	/// Increments and saves the app opening count
	public func incrementAppOpeningsCount() {
		var count = integer(forKey: "openingCount")
		count += 1
		set(count, forKey: "openingCount")
	}

	/// Returns a bool indicating whether the user has bought the remove ads iAP
	public var didPurchaseRemoveAds: Bool {
		get { return bool(forKey: "didPurchaseRemoveAds") }
		set { set(newValue, forKey: "didPurchaseRemoveAds") }
	}

}
