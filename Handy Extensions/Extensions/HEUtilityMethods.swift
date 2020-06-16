//
//  HEUtilityMethods.swift
//  Handy Extensions
//
//  Created by Arthur Avagyan on 6/15/20.
//

import Foundation

extension Int {
	
	func formatterDurationString(_ isFullFormat: Bool = false) -> String {
		let secondsString = String(format: "%02d", self % 60)
		let minutesString = String(format: "%02d", (self / 60) % 60)
		let hoursString = isFullFormat ? String(format: "%02d", (self / 3600)) : String(self / 3600)

		return "\(hoursString != "0" ? hoursString + ":" : "")\(minutesString):\(secondsString)"
	}
	
	func formatterDurationAutomaticallString(_ isFullFormat: Bool = false) -> String {
		let secondsString = String(format: "%02d", self % 60)
		let minutesString = String(format: "%02d", (self / 60) % 60)
		let hoursString = isFullFormat ? String(format: "%02d", (self / 3600)) : String(self / 3600)

		return "\(self / 3600 != 0 ? hoursString + ":" : "")\(minutesString):\(secondsString)"
	}
}

extension String {
	
	func isValidEmail() -> Bool {
		return isMatchingRegex("^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$")
	}
	
	func isValidPhoneNumber() -> Bool {
		return isMatchingRegex("^(\\+)[0-9]{6,15}$")
	}

	func isArmenianPhoneNumber() -> Bool {
		return isMatchingRegex("^(\\+)[0-9]{11}$")
	}
	
	func isMatchingRegex(_ pattern: String) -> Bool {
		let range = NSRange(location: 0, length: self.utf16.count)
		let regex = NSRegularExpression(pattern)
		return regex.firstMatch(in: self, options: [], range: range) != nil
	}
	
	func replacePrefix(_ prefix: String, replacement: String) -> String {
		return (hasPrefix(prefix) ? (replacement + self[prefix.endIndex...]) : self)
	}
}

extension NSRegularExpression {
	
	convenience init(_ pattern: String) {
		do {
			try self.init(pattern: pattern)
		} catch {
			preconditionFailure("Illegal regular expression: \(pattern).")
		}
	}
}
