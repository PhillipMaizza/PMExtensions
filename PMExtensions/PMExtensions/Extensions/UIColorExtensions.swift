//
//  UIColorExtensions.swift
//  PMExtensions
//
//  Created by Phillip Maizza on 22/02/2019.
//  Copyright © 2019 Phillip Maizza. All rights reserved.
//

import Foundation

public extension UIColor {

	/// Returns an hex string of a color
	public var toHex: String {
		var red: CGFloat = 0
		var green: CGFloat = 0
		var blue: CGFloat = 0
		var alpha: CGFloat = 0

		getRed(&red, green: &green, blue: &blue, alpha: &alpha)

		let rgb: Int = (Int)(red * 255)<<16 | (Int)(green * 255)<<8 | (Int)(blue * 255)<<0

		return NSString(format: "#%06x", rgb) as String
	}

	/// Returns a color from an hex
	public convenience init(hex: String, alpha: CGFloat = 1) {
		var cleanedHexString = hex
		if hex.hasPrefix("#") {
			cleanedHexString = String(hex.dropFirst())
		}

		var rgbValue: UInt32 = 0
		Scanner(string: cleanedHexString).scanHexInt32(&rgbValue)

		let red = CGFloat((rgbValue >> 16) & 0xff) / 255.0
		let green = CGFloat((rgbValue >> 08) & 0xff) / 255.0
		let blue = CGFloat((rgbValue >> 00) & 0xff) / 255.0

		self.init(red: red, green: green, blue: blue, alpha: alpha)
	}

	/// Returns an r g b color
	public convenience init(red: CGFloat, green: CGFloat, blue: CGFloat) {
		self.init(red: red/255, green: green/255, blue: blue/255, alpha: 1.0)
	}

	/// Returns Facebook's main color
	static public let facebook = UIColor(hex: "3B5998")

	/// Returns the color of a table view
	static public let tableView = UIColor(hex: "eaeaea")

	/// Returns the color of a table view section
	static public let tableViewSection = UIColor(hex: "6d6d72")

	/// Returns the color of a table view separator
	static public let tableViewSeparator = UIColor(hex: "c8c7cc")

	/// Returns a flat light green / cyan color
	public static let turquoise = UIColor(red: 26, green: 188, blue: 156)

	/// Returns a flat dark green sea color
	public static let greenSea = UIColor(red: 22, green: 160, blue: 133)

	/// Returns a flat light green color
	public static let emerald = UIColor(red: 46, green: 204, blue: 113)

	/// Returns a flat dark green color
	public static let nephritis = UIColor(red: 39, green: 174, blue: 96)

	/// Returns a flat light cyan color
	public static let peterRiver = UIColor(red: 52, green: 152, blue: 219)

	/// Returns a flat dark cyan color
	public static let belizeHole = UIColor(red: 41, green: 128, blue: 185)

	/// Returns a flat light purple color
	public static let amethyst = UIColor(red: 155, green: 89, blue: 182)

	/// Returns a flat dark purple color
	public static let wisteria = UIColor(red: 142, green: 68, blue: 173)

	/// Returns a flat light black - blue color
	public static let wetAsphalt = UIColor(red: 52, green: 73, blue: 94)

	/// Returns a flat dark black - blue color
	public static let midnightBlue = UIColor(red: 44, green: 62, blue: 80)

	/// Returns a flat light yellow color
	public static let sunflower = UIColor(red: 241, green: 196, blue: 15)

	/// Returns a flat dark yellow - orange color
	public static let carrot = UIColor(red: 230, green: 126, blue: 34)

	/// Returns a flat dark orange - red color
	public static let pumpkin = UIColor(red: 211, green: 84, blue: 0)

	/// Returns a flat light red color
	public static let alizarin = UIColor(hex: "#E64A19")//(red:231, g:76, b:60)

	/// Returns a flat dark red color
	public static let pomergranate = UIColor(red: 192, green: 57, blue: 43)

	/// Returns a flat light white - gray color
	public static let clouds = UIColor(red: 236, green: 240, blue: 241)

	/// Returns a flat dark white - gray color
	public static let silver = UIColor(red: 189, green: 195, blue: 199)

	/// Returns a flat light gray color
	public static let concrete = UIColor(red: 149, green: 165, blue: 166)

	/// Returns a flat dark gray color
	public static let asbestos = UIColor(red: 127, green: 140, blue: 141)

	/// Returns a flat orange color
	public static let flatOrange = UIColor(red: 243, green: 156, blue: 18)
}
