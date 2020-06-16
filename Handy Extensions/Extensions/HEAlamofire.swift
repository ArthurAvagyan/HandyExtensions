//
//  HEAlamofire.swift
//  Handy Extensions
//
//  Created by Arthur Avagyan on 6/15/20.
//

import Foundation
import Alamofire

extension DataRequest {

	@discardableResult
	public func customValidation(_ allowsEmptyBody: Bool = false) -> Self {
		return validateStatus(allowsEmptyBody).validate(contentType: [HERequestConstants.contentType])
	}
	
	@discardableResult
	public func validateStatus(_ allowsEmptyBody: Bool) -> Self {
		return validate { [unowned self] (request, response, data) -> DataRequest.ValidationResult in
			self.validateStatusCodes(request, response, data, allowsEmptyBody)
		}
	}
	
	fileprivate func validateStatusCodes(_ request: URLRequest?, _ response: HTTPURLResponse, _ data: Data?, _ allowsEmptyBody: Bool = false) -> ValidationResult {
		let emptyResponseCodes = allowsEmptyBody ? [200, 204, 205] : JSONResponseSerializer.defaultEmptyResponseCodes
		let responseSerializer = JSONResponseSerializer(emptyResponseCodes: emptyResponseCodes)
		return validate(request, response, responseSerializer, data)
    }
	
	fileprivate func validate(_ request: URLRequest?, _ response: HTTPURLResponse, _ responseSerializer: JSONResponseSerializer, _ data: Data?) -> ValidationResult {
		do {
			if !(NetworkReachabilityManager.default?.isReachable ?? false) {
				return .failure(KCValidationError.customError(HEAlertConstants.internetConnection))
			}
			let result = try responseSerializer.serialize(request: request, response: response, data: data, error: nil)
			if let resp = result as? [String: Any], let message = resp[HEResponseConstants.messageKey] as? String, !message.isEmpty {
				return .failure(KCValidationError.customError(message))
			}
			if !HERequestConstants.acceptableStatusCodes.contains(response.statusCode) {
				return .failure(AFError.responseValidationFailed(reason: .unacceptableStatusCode(code: response.statusCode)))
			}
			return .success(Void())
		} catch let error {
			return .failure(AFError.responseSerializationFailed(reason: .jsonSerializationFailed(error: error)))
		}
	}
}

enum KCValidationError: Error {
	case customError(String)
}

extension KCValidationError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case let .customError(reason):
			return reason
        }
    }
	var localizedDescription: String {
		switch self {
        case let .customError(reason):
			return reason
        }
	}
}

extension AFError {
	
	public var description: String {
		return (self.underlyingError as? KCValidationError)?.errorDescription ?? self.localizedDescription
	}
}
