//
//  HEAuthorizationManager.swift
//  Handy Extensions
//
//  Created by Arthur Avagyan on 6/15/20.
//

import Foundation

class HEAuthorizationManager {
	
	func storeToken(_ token: String) {
		UserDefaults.standard.set(token, forKey: HERequestConstants.tokenKey)
	}
	
	func unauthorized() {
		
	}
}

