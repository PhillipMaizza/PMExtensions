//
//  BundleExtensions.swift
//  PMExtensions
//
//  Created by Phillip Maizza on 22/02/2019.
//  Copyright © 2019 Phillip Maizza. All rights reserved.
//

import Foundation

public extension Bundle {

	/// Returns the string containing the app version
	public var appVersion: String {
		return self.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
	}

	/// Returns the string containing the build version
	public var buildVersion: String {
		return self.infoDictionary?["CFBundleVersion"] as? String ?? ""
	}

	/// Returns an integer containing both the app and builds version number without dots
	public var appAndBuildVersionNumber: Int {
		let appVersionT = appVersion.replacingOccurrences(of: ".", with: "")
		let bundleVersionT = buildVersion.replacingOccurrences(of: ".", with: "")
		let stringVersion = appVersionT + bundleVersionT
		if let intVersion = Int(stringVersion) {
			return intVersion
		}

		return 0
	}

	/// Returns a string containing the app build and version number formatted
	public var appAndBuildVersionFormatted: String {
		let appVersionT = appVersion
		let bundleVersionT = buildVersion
		return appVersionT + "b\(bundleVersionT)"
	}

}
