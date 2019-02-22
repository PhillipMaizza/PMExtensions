//
//  StringExtensions.swift
//  PMExtensions
//
//  Created by Phillip Maizza on 22/02/2019.
//  Copyright © 2019 Phillip Maizza. All rights reserved.
//

import Foundation

public extension String {

	public subscript(value: NSRange) -> Substring {
		return self[value.lowerBound..<value.upperBound]
	}

	public subscript(value: CountableClosedRange<Int>) -> Substring {
		return self[index(at: value.lowerBound)...index(at: value.upperBound)]
	}

	public subscript(value: CountableRange<Int>) -> Substring {
		return self[index(at: value.lowerBound)..<index(at: value.upperBound)]
	}

	public subscript(value: PartialRangeUpTo<Int>) -> Substring {
		return self[..<index(at: value.upperBound)]
	}

	public subscript(value: PartialRangeThrough<Int>) -> Substring {
		return self[...index(at: value.upperBound)]
	}

	public subscript(value: PartialRangeFrom<Int>) -> Substring {
		return self[index(at: value.lowerBound)...]
	}

	public func index(at offset: Int) -> String.Index {
		return index(startIndex, offsetBy: offset)
	}

	/// Returns a localized version of the string
	public var localized: String { return NSLocalizedString(self, comment: "") }

	/// Returns the length of the string
	public var length: Int { return count }

	/// Returns the first character of a string
	public var first: String { return String(prefix(1))	}

	/// Returns the last character of a string
	public var last: String { return String(suffix(1)) }

	/// Returns a capitalized version of the string
	public var capitalizeFirst: String { return first.uppercased() + String(dropFirst()) }

	/// Returns a bool value of a string
	public var boolValue: Bool { return NSString(string: self).boolValue }

	/// Tests for a regex
	public func regExTest(_ regEx: String) -> Bool {
		do {
			let internalExpression = try NSRegularExpression(pattern: regEx, options: .caseInsensitive)
			let matches = internalExpression.numberOfMatches(in: self, options: NSRegularExpression.MatchingOptions(), range: NSRange(location: 0, length: length))
			return matches > 0
		} catch {
			return false
		}

	}

	/// Returns an array containing all the strings matching a regex
	public func regExMatches(_ regEx: String) -> [String] {
		do {
			var ret = [String]()
			let internalExpression = try NSRegularExpression(pattern: regEx, options: .caseInsensitive)
			let matches = internalExpression.matches(in: self, options: NSRegularExpression.MatchingOptions(), range: NSRange(location: 0, length: length))

			for match in matches {
				let startIndex = match.range.location
				let endIndex = startIndex + match.range.length

				let start = self.index(self.startIndex, offsetBy: startIndex, limitedBy: self.endIndex)
				let end = self.index(self.startIndex, offsetBy: endIndex, limitedBy: self.endIndex)
				if start! >= self.endIndex {
					break
				}
				ret.append(self.substring(with: start!..<end!))
			}

			return ret
		} catch {
			return [String]()
		}
	}

	/// Returns an array containing a group of all the strings matching a regex
	public func regExGroups(_ regEx: String) -> [String] {
		do {

			var ret = [String]()
			let internalExpression = try NSRegularExpression(pattern: regEx, options: .caseInsensitive)

			let numGroups = internalExpression.numberOfCaptureGroups

			let matches = internalExpression.matches(in: self, options: NSRegularExpression.MatchingOptions(), range: NSRange(location: 0, length: length))
			for match in matches {
				interno: for idx in 1...numGroups {
					let range = match.range(at: idx)
					let startIndex = range.location
					let endIndex = startIndex + range.length

					let start = self.index(self.startIndex, offsetBy: startIndex, limitedBy: self.endIndex)
					let end = self.index(self.startIndex, offsetBy: endIndex, limitedBy: self.endIndex)
					if start! >= self.endIndex {
						break interno
					}
					ret.append(self.substring(with: start!..<end!))
				}

			}
			return ret
		} catch {
			return [String]()
		}
	}

	/// Returns a string to date from UTC
	public var toDate: Date? {
		let dateFormatter = DateFormatter()
		dateFormatter.locale = Locale(identifier: "en_US_POSIX")
		dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
		dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"
		dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
		var date = dateFormatter.date(from: self)

		if date == nil {
			dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
			date = dateFormatter.date(from: self)
		}

		if date == nil {
			dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
			date = dateFormatter.date(from: self)
		}

		if date == nil {
			dateFormatter.dateFormat = "yyyy-MM-dd"
			date = dateFormatter.date(from: self)
		}

		return date
	}

	/// Checks if email is a valid one
	public var isEmailValid: Bool {
		let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
		let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
		return emailTest.evaluate(with: self)
	}

	/// Returns a dictionary version of the string
	public var toDictionary: [String: Any]? {
		if let data = self.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue)) {
			do {
				return try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject]
			} catch let error as NSError {
				print(error.localizedDescription)
			}
		}

		return nil
	}

	/// Converts a string to time
	public var toTime: NSNumber {
		let arrayString = self.split { $0 == " " || $0 == ":" }.map(String.init)

		var daysNumber = "0"
		var hoursNumber = "0"
		var minutesNumber = "0"
		var secondsNumber = "0"

		if arrayString.count == 4 {
			daysNumber = arrayString[0]
			hoursNumber = arrayString[1]
			minutesNumber = arrayString[2]
			secondsNumber = arrayString[3]
		} else if arrayString.count == 3 {
			hoursNumber = arrayString[0]
			minutesNumber = arrayString[1]
			secondsNumber = arrayString[2]
		}

		let days =  Int64(daysNumber)! * 24 * 60 * 60
		let hours = Int64(hoursNumber)! * 60 * 60
		let minutes = Int64(minutesNumber)! * 60
		let seconds = Int64(secondsNumber)!
		let total = days + hours + minutes + seconds

		return NSNumber(value: total as Int64)
	}

	/// Returns a string starting from a time in number
	public static func fromTime(_ time: NSNumber) -> String {
		var tempTime = time.intValue

		let days = tempTime / (24 * 60 * 60)
		tempTime = tempTime % (24 * 60 * 60)

		let hours = tempTime  / (60 * 60)
		tempTime = tempTime % (60 * 60)

		let minutes = tempTime / 60

		tempTime = tempTime % (60)
		let seconds = tempTime

		let hoursS = hours<10 ? "0\(hours)" : "\(hours)"
		let minutesS = minutes<10 ? "0\(minutes)" : "\(minutes)"
		let secondsS = seconds<10 ? "0\(seconds)" : "\(seconds)"

		if days > 0 {
			return "\(days) \(hoursS):\(minutesS):\(secondsS)"
		} else {
			return "\(hoursS):\(minutesS):\(secondsS)"
		}
	}
}
