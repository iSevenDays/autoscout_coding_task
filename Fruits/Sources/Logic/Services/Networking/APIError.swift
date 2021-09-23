//
//  APIError.swift
//  Fruits
//
//  Created by Anton Sokolchenko on 07.09.2021.
//

import Foundation

enum APIError: Error {
	case requestFailed
	case jsonConversionFailure
	case invalidData
	case responseUnsuccessful
	case jsonParsingFailure
	var localizedDescription: String {
		switch self {
		case .requestFailed: return "Request Failed"
		case .invalidData: return "Invalid Data"
		case .responseUnsuccessful: return "Response Unsuccessful"
		case .jsonParsingFailure: return "JSON Parsing Failure"
		case .jsonConversionFailure: return "JSON Conversion Failure"
		}
	}
}
