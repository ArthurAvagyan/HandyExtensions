//
//  HENetworking.swift
//  Handy Extensions
//
//  Created by Arthur Avagyan on 6/15/20.
//

import Foundation
import Alamofire

enum KCNetworking {
	
	private static var headers: HTTPHeaders {
		var header: HTTPHeaders = [	.contentType(HERequestConstants.contentType),
									.init(name: "accept", value: HERequestConstants.contentType)]
		
		if let deviceToken = UserDefaults.standard.object(forKey: HERequestConstants.deviceTokenKey) as? String {
			header.add(name: HERequestConstants.sessionKey, value: deviceToken)
		} else if let deviceID = UIDevice.current.identifierForVendor?.uuidString {
			header.add(name: HERequestConstants.sessionKey, value: deviceID)
		}
		if let token = UserDefaults.standard.object(forKey: HERequestConstants.tokenKey) as? String {
			header.add(.authorization(token))
		}
		return header
	}
	
	static func request(_ url: URLConvertible, method: HTTPMethod = .get, parameters: Parameters? = nil, encoding: ParameterEncoding = JSONEncoding.default, headers: HTTPHeaders? = headers, interceptor: RequestInterceptor? = nil, allowsEmptyBody: Bool = false) -> DataRequest {
		return AF.request("\(HEConstants.serverUrl)\(url)", method: method, parameters: parameters, encoding: encoding, headers: headers, interceptor: interceptor).customValidation(allowsEmptyBody).response { (response) in
			guard response.response?.statusCode != HEConstants.unauthorizedCode else {
				HEDataManager.authorizationManager.unauthorized()
				return
			}
			if let token = response.response?.allHeaderFields[HERequestConstants.authorizationKey] as? String {
				HEDataManager.authorizationManager.storeToken(token)
			}	
		}
	}
}
