//
//  DateExtensions.swift
//  PMExtensions
//
//  Created by Phillip Maizza on 22/02/2019.
//  Copyright © 2019 Phillip Maizza. All rights reserved.
//

import Foundation

public extension Date {

	/// Returns the day component from a date
	public var day: Int {
		return Calendar.current.dateComponents([.day], from: self).day ?? 0
	}

	/// Returns the month component from a date
	public var month: Int {
		return Calendar.current.dateComponents([.month], from: self).month ?? 0
	}

	/// Returns the year component from a date
	public var year: Int {
		return Calendar.current.dateComponents([.year], from: self).year ?? 0
	}

	/// Returns the hour component from a date
	public var hour: Int {
		return Calendar.current.dateComponents([.hour], from: self).hour ?? 0
	}

	/// Returns the minute component from a date
	public var minute: Int {
		return Calendar.current.dateComponents([.minute], from: self).minute ?? 0
	}

	/// Returns the second component from a date
	public var second: Int {
		return Calendar.current.dateComponents([.second], from: self).second ?? 0
	}

	/// Returns the weekday component from a date
	public var weekday: Int {
		return Calendar.current.dateComponents([.weekday], from: self).weekday ?? 0
	}

	/// Converts a date to string using yyyy-MM-dd'T'HH:mm:ss.SSS format
	public var toString: String {
		return toString(withFormat: "yyyy-MM-dd'T'HH:mm:ss.SSS")
	}

	/// Converts a date to string using a custom format
	public func toString(withFormat format: String) -> String {
		let dateFormatter = DateFormatter()
		dateFormatter.locale = Locale.current
		dateFormatter.timeZone = TimeZone.current
		dateFormatter.dateFormat = format
		return dateFormatter.string(from: self)
	}

	/// Returns a date starting at 00:00
	public var midnight: Date? {
		let calendar = Calendar.current
		var dateComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: self)
		dateComponents.hour = 0
		dateComponents.minute = 0
		return calendar.date(from: dateComponents)
	}

	/// Returns a custom date
	public func custom(year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int) -> Date? {
		let calendar = Calendar.current
		var dateComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: self)
		dateComponents.year = year
		dateComponents.month = month
		dateComponents.day = day
		dateComponents.hour = hour
		dateComponents.hour = minute
		dateComponents.second = second

		return calendar.date(from: dateComponents)
	}

	/// Calculates the age from a date
	public var age: Int {
		let calendar = Calendar.current
		let now = calendar.startOfDay(for: Foundation.Date())
		let birthdate = calendar.startOfDay(for: self)
		let dateComponents = calendar.dateComponents([.year], from: birthdate, to: now)
		return dateComponents.year ?? 0
	}

	/// Returns a bool indicating whether a date is between another date
	public func isBetween(_ endDate: Date) -> Bool {
		if compare(self) == .orderedAscending || compare(self) == .orderedSame {
			return false
		}

		if compare(endDate) == .orderedDescending || compare(endDate) == .orderedSame {
			return false
		}

		return true
	}

	/// Returns a bool indicating whether a date is between or equal to another date
	public func isBetweenOrEqualTo(_ endDate: Foundation.Date) -> Bool {
		if compare(self) == .orderedAscending {
			return false
		}

		if compare(endDate) == .orderedDescending {
			return false
		}

		return true
	}

	/// Returns a bool indicating whether a date is the same as another one to a specific granularity
	public func sameDate(as date: Date, granularity: Calendar.Component) -> Bool {
		return .orderedSame == Calendar.current.compare(self, to: date, toGranularity: granularity)
	}

	/// Returns a bool indicating whether a date is greater than another one
	public func isGreaterThan(_ endDate: Date) -> Bool {
		return self.compare(endDate) == .orderedDescending
	}

	/// Returns a bool indicating whether a date is less than another one
	public func isLessThan(_ endDate: Foundation.Date) -> Bool {
		return self.compare(endDate) == .orderedAscending
	}

	/// Adds days to a date
	public func add(days: Int) -> Foundation.Date {
		let secondsInDays = Double(days) * 60 * 60 * 24
		let dateWithDaysAdded = self.addingTimeInterval(secondsInDays)
		return dateWithDaysAdded
	}

	/// Adds days to a date
	public func add(hours: Int) -> Foundation.Date {
		let secondsInHours = Double(hours) * 60 * 60
		let dateWithHoursAdded = self.addingTimeInterval(secondsInHours)
		return dateWithHoursAdded
	}

	/// Adds minutes to a date
	public func add(minutes: Int) -> Foundation.Date {
		let secondsInMinutes = Double(minutes) * 60
		let dateWithHoursAdded = self.addingTimeInterval(secondsInMinutes)
		return dateWithHoursAdded
	}

	/// Adds seconds to a date
	public func add(seconds: Int) -> Foundation.Date {
		let secondsInMinutes = Double(seconds)
		let dateWithHoursAdded = self.addingTimeInterval(secondsInMinutes)
		return dateWithHoursAdded
	}

	/// Returns the amount of years from another date
	public func years(from date: Date) -> Int {
		return Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0
	}

	/// Returns the amount of months from another date
	public func months(from date: Date) -> Int {
		return Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0
	}

	/// Returns the amount of weeks from another date
	public func weeks(from date: Date) -> Int {
		return Calendar.current.dateComponents([.weekOfMonth], from: date, to: self).weekOfMonth ?? 0
	}

	/// Returns the amount of days from another date
	public func days(from date: Date) -> Int {
		return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
	}

	/// Returns the amount of hours from another date
	public func hours(from date: Date) -> Int {
		return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
	}

	/// Returns the amount of minutes from another date
	public func minutes(from date: Date) -> Int {
		return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
	}

	/// Returns the amount of seconds from another date
	public func seconds(from date: Date) -> Int {
		return Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0
	}

	/// Returns the a custom time interval description from another date
	public func offset(from date: Date) -> String {
		if years(from: date)   > 0 { return "\(years(from: date))y"   }
		if months(from: date)  > 0 { return "\(months(from: date))M"  }
		if weeks(from: date)   > 0 { return "\(weeks(from: date))w"   }
		if days(from: date)    > 0 { return "\(days(from: date))d"    }
		if hours(from: date)   > 0 { return "\(hours(from: date))h"   }
		if minutes(from: date) > 0 { return "\(minutes(from: date))m" }
		if seconds(from: date) > 0 { return "\(seconds(from: date))s" }
		return ""
	}
}
