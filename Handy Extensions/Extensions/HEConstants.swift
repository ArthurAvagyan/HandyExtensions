//
//  HEConstants.swift
//  Handy Extensions
//
//  Created by Arthur Avagyan on 6/15/20.
//

import Foundation

class HEConstants {
	
	static var serverUrl = ""
	static let unauthorizedCode = 401
}

struct HERequestConstants {
	
	static let tokenKey = "token"
	static let sessionKey = "Session"
	static let referrerKey = "referrer-app"
	static let deviceTokenKey = "deviceToken"
	static let contentType = "application/json"
	static let authorizationKey = "Authorization"
	static let acceptableStatusCodes = Range(200...299)
}

struct HEResponseConstants {
	
	static let messageKey = "message"
}


struct HEAlertConstants {
	
	static let okay = "Okay"
	static let cancel = "Cancel"
	static let settings = "Settings"
	static let internetConnection = "Please check Your internet connection and try again"
}

enum HEPermission: String {	
	
	case camera = "camera"
	case microphone = "microphone"
}
